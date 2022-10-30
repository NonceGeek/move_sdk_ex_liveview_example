const prefix = 'AptosWallet#'

const toKey = (key) => `${prefix}${key}`
const get = (key) => localStorage.getItem(toKey(key))
const set = (key, item) => localStorage.setItem(toKey(key), item)

export const getLastConnectedWalletType = () => get('last-connected-wallet-type')
export const setLastConnectedWalletType = (type) => set('last-connected-wallet-type', type)
