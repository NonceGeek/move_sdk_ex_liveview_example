import { toStringRecursive } from './utils'

export const connect = async () => {
  const notInstalledError = new Error('Martian wallet not installed.')

  if (!window.martian) return Promise.reject(notInstalledError)

  const martianRes = await window.martian.connect()
  if (!martianRes) return

  const chainId = async () => {
    return (await window.martian.getChainId()).chainId
  }

  const wallet = {
    type: 'martian',
    account: async () => {
      return (await window.martian.account()).address
    },
    network: async () => {
      return window.martian.network()
    },
    chainId,
    disconnect: async () => {
      return window.martian.disconnect()
    },
    signMessage: async (payload) => {
      return window.martian.signMessage(payload)
    },
    signAndSubmitTransaction: async (payload) => {
      const tx = await window.martian.generateTransaction(
        window.martian.address,
        { ...payload, arguments: payload.arguments.map(toStringRecursive) }
      )
      return window.martian.signAndSubmitTransaction(tx)
    },
    onAccountChanged: (listener) => {
      return window.martian.onAccountChange(listener)
    },
    onNetworkChanged: (listener) => {
      return window.martian.onNetworkChange(listener)
    },
    onChainChanged: (listener) => {
      return window.martian.onNetworkChange(() => chainId().then(listener))
    }
  }

  return wallet
}
