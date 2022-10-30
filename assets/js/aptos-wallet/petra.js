import { toStringRecursive } from './utils'

export const connect = async () => {
  const notInstalledError = new Error('Petra wallet not installed')
  const notSupportedError = new Error('Petra wallet not supported')

  if (!window.aptos) return Promise.reject(notInstalledError)

  const aptosRes = await window.aptos.connect()
  if (!aptosRes) return

  const wallet = {
    type: 'aptos',
    account: async () => {
      if (!window.aptos) return Promise.reject(notInstalledError)
      return (await window.aptos.account()).address
    },
    network: async () => {
      if (!window.aptos) return Promise.reject(notInstalledError)
      return window.aptos.network()
    },
    chainId: () => Promise.reject(notSupportedError),
    disconnect: async () => {
      if (!window.aptos) return Promise.reject(notInstalledError)
      return window.aptos.disconnect()
    },
    signMessage: async (payload) => {
      return window.aptos.signMessage(payload)
    },
    signAndSubmitTransaction: async (payload) => {
      if (!window.aptos) return Promise.reject(notInstalledError)
      return window.aptos.signAndSubmitTransaction({
        ...payload,
        arguments: payload.arguments.map(toStringRecursive)
      })
    },
    onAccountChanged: (listener) => {
      if (!window.aptos) throw new Error(notInstalledError)
      window.aptos.on('accountChanged', (params) =>
        listener(params)
      )
    },
    onNetworkChanged: (listener) => {
      if (!window.aptos) throw new Error(notInstalledError)
      window.aptos.on('networkChanged', listener)
    }
  }
  return wallet
}
