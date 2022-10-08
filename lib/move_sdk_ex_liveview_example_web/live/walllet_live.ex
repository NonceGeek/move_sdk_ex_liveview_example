defmodule MoveSDKExLiveviewExampleWeb.WalletLive do
    @moduledoc """
      Copy from:
      > https://github.com/myastrallabs/stormstout
    """

    use MoveSDKExLiveviewExampleWeb, :live_view


    @impl true
    def mount(_, _session, socket) do
      {:ok, socket}
    end

    @impl true
    def handle_params(params, _url, socket) do
      {:noreply, apply_action(socket, socket.assigns.live_action, params)}
    end

    def apply_action(socket, :index, _params) do
      socket
      |> assign(page_header: "Wallet List")
    end

    @impl true
    def render(assigns) do
      ~H"""
      <div class="my-2 space-x-4 max-w-[80rem] mx-auto">
        <.modal id="wallet-modal-2" show={true} class="min-w-[25%]" title="Connect">
          <%= live_render(@socket, MoveSDKExLiveviewExampleWeb.WalletButtonLive, id: "connect", session: %{"id" => "wallet-connect", "text" => "Log in with Petra Wallet"}) %>
        </.modal>
      </div>
      """
    end
  end
