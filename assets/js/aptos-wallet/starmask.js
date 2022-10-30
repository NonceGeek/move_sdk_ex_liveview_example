import { toStringRecursive } from './utils'

export const connect = async () => {
  const notInstalledError = new Error('Starmask wallet not installed')
  const notSupportedError = new Error('Starmask wallet not supported')

  if (!window.starcoin) return Promise.reject(notInstalledError)

  const starcoinRes = await window.starcoin.request({ method: 'stc_requestAccounts' })

  if (!starcoinRes) return

  const wallet = {
    type: 'starmask',
    account: async () => {
      if (!window.starcoin) return Promise.reject(notInstalledError)
      return (await window.starcoin.request({method: 'stc_accounts'}))[0]
    },
    disconnect: async () => {
      if (!window.starcoin) return Promise.reject(notInstalledError)
      return window.starcoin.request({method: 'wallet_requestPermissions', params: [{ stc_accounts: {}}]})
    },
  }
  return wallet
}
