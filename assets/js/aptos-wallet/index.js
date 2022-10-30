import { getLastConnectedWalletType, setLastConnectedWalletType } from './utils/localstorage'

import { connect as connectAptosWallet } from './petra'
import { connect as connectMartianWallet } from './martian'
import { connect as connectStarmaskWallet } from './starmask'

const connectWallet = async (type) => {
  console.log('type:', type)
  switch (type) {
    case 'aptos':
      return connectAptosWallet()
    case 'martian':
      return connectMartianWallet()
    case 'starmask':
      return connectStarmaskWallet()
  }
}

export const connect = async (type) => {
  const wallet = await connectWallet(type)
  if (wallet) setLastConnectedWalletType(type)
  return wallet
}

export const lastConnectedWalletType = () => {
  const type = getLastConnectedWalletType()
  return type
}
