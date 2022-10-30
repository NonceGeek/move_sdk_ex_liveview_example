import { connect, lastConnectedWalletType } from '../aptos-wallet'

export const Wallet = {
  mounted () {
    let wallet

    window.addEventListener('load', async () => {
      console.log('load')
      const walletType = lastConnectedWalletType()

      if (walletType) {
        wallet = await connect(walletType)
        const address = await wallet.account()
        this.pushEvent('wallet-info', { address: address, walletType: walletType })
      }
    })

    window.addEventListener('phx:connect-petra', async () => {
      console.log("connect petra")
      wallet = await connect('aptos')

      const address = await wallet.account()
      this.pushEvent('wallet-info', { address: address, walletType: 'petra' })
    })

    window.addEventListener('phx:connect-martian', async () => {
      console.log("connect martian")
      wallet = await connect('martian')

      const address = await wallet.account()
      this.pushEvent('wallet-info', { address: address, walletType: 'martian' })
    })

    window.addEventListener('phx:connect-starmask', async () => {
      console.log("connect starmask")
      wallet = await connect('starmask')
      const address = await wallet.account()
      this.pushEvent('wallet-info', { address: address, walletType: 'starmask' })
    })

    window.addEventListener('phx:disconnect', async () => {
      console.log("disconnect")
      await wallet.disconnect()
      this.pushEvent('wallet-info', { address: null, walletType: null })
    })
  }
}