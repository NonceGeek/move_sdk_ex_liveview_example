defmodule MoveSDKExLiveviewExampleWeb.WalletLive do
  @moduledoc false

  use MoveSDKExLiveviewExampleWeb, :live_view

  @impl true
  def mount(_, session, socket) do
    {:ok,
     socket
     |> assign_new(:connected, fn -> false end)
     |> assign_new(:id, fn -> session["id"] end)
     |> assign_new(:current_wallet_address, fn -> nil end)
     |> assign_new(:wallet_type, fn -> nil end)}
  end

  @impl true
  def handle_event("wallet-info", %{"address" => address, "walletType" => wallet_type}, socket) do
    connected = if address, do: true, else: false

    {:noreply,
     socket
     |> assign(:current_wallet_address, address)
     |> assign(:connected, connected)
     |> assign(:wallet_type, wallet_type)}
  end

  @impl true
  def handle_event("connect-petra", _, socket) do
    {:noreply, push_event(socket, "connect-petra", %{})}
  end

  @impl true
  def handle_event("connect-martian", _, socket) do
    {:noreply, push_event(socket, "connect-martian", %{})}
  end

  @impl true
  def handle_event("connect-starmask", _, socket) do
    {:noreply, push_event(socket, "connect-starmask", %{})}
  end

  @impl true
  def handle_event("disconnect", _, socket) do
    {:noreply, push_event(socket, "disconnect", %{})}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <div class="sm:flex sm:gap-4" id={@id} phx-hook="Wallet">
        <p class="text-white">
          <%= @current_wallet_address %>
        </p>
        <a
          class="rounded-md bg-teal-600 px-5 py-2.5 text-sm font-medium text-white shadow"
        >
          <button phx-click="connect-starmask">Connect Starmask</button>
        </a>

        <a
          class="rounded-md bg-teal-600 px-5 py-2.5 text-sm font-medium text-white shadow"
        >
          <button phx-click="connect-martian">Connect Martian</button>
        </a>

        <a
          class="rounded-md bg-teal-600 px-5 py-2.5 text-sm font-medium text-white shadow"
        >
          <button phx-click="connect-petra">Connect Petra</button>
        </a>

        <div class="hidden sm:flex">
          <a
            class="rounded-md bg-gray-100 px-5 py-2.5 text-sm font-medium text-teal-600"
          >
            <%= if @connected do %>
              <button phx-click="disconnect">Disconnect</button>
            <% end %>
          </a>

        </div>
      </div>

    """
  end
end
