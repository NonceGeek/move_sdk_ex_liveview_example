defmodule MoveSDKExLiveviewExampleWeb.ExampleLive do
  use MoveSDKExLiveviewExampleWeb, :live_view

  alias MoveSDKExLiveviewExample.ContractInteractor.{Library, EthSigVerifier}

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"lib" => %{"addr_input" => addr}}, _uri, socket) do
    {status, books} = Library.get_resource(addr, :library)
    {
      :noreply,
      socket
      |> assign(:books, books)
      |> assign(:book_res_status, status)
    }
  end

  def handle_params(%{"eth_sig_verfier" => params}, _uri, socket) do
    %{signature_input: sig, addr_input: addr, msg_input: msg} =
      ExStructTranslator.to_atom_struct(params)
    {status, sig_verify_result} = EthSigVerifier.call_func(:verify_eth_sig, sig, addr, msg)
    {
      :noreply,
      socket
      |> assign(:sig_verify_result, sig_verify_result)
      |> assign(:sig_res_status, status)
    }
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="h-screen overflow-auto dark:bg-gray-900">
      <nav class="sticky top-0 flex items-center justify-between w-full h-16 bg-white dark:bg-gray-900">
        <div class="flex ml-3 sm:ml-10">
          <a
          class="inline-flex items-center gap-2 p-2 text-gray-500 rounded dark:text-gray-400 dark:hover:text-gray-500 hover:text-gray-400 group"
            href="/"
          >
            <span class="hidden font-semibold sm:block">
              Move Ex Example
            </span>
          </a>
        </div>

        <div class="flex justify-end gap-3 pr-4">
          <a
            target="_blank"
            class="inline-flex items-center gap-2 p-2 text-gray-500 rounded dark:text-gray-400 dark:hover:text-gray-500 hover:text-gray-400 group"
            href="https://github.com/WeLightProject/move_sdk_ex_liveview_example"
          >
            <svg
              class="w-5 h-5 fill-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              data-name="Layer 1"
              viewBox="0 0 24 24"
            >
              <path d="M12,2.2467A10.00042,10.00042,0,0,0,8.83752,21.73419c.5.08752.6875-.21247.6875-.475,0-.23749-.01251-1.025-.01251-1.86249C7,19.85919,6.35,18.78423,6.15,18.22173A3.636,3.636,0,0,0,5.125,16.8092c-.35-.1875-.85-.65-.01251-.66248A2.00117,2.00117,0,0,1,6.65,17.17169a2.13742,2.13742,0,0,0,2.91248.825A2.10376,2.10376,0,0,1,10.2,16.65923c-2.225-.25-4.55-1.11254-4.55-4.9375a3.89187,3.89187,0,0,1,1.025-2.6875,3.59373,3.59373,0,0,1,.1-2.65s.83747-.26251,2.75,1.025a9.42747,9.42747,0,0,1,5,0c1.91248-1.3,2.75-1.025,2.75-1.025a3.59323,3.59323,0,0,1,.1,2.65,3.869,3.869,0,0,1,1.025,2.6875c0,3.83747-2.33752,4.6875-4.5625,4.9375a2.36814,2.36814,0,0,1,.675,1.85c0,1.33752-.01251,2.41248-.01251,2.75,0,.26251.1875.575.6875.475A10.0053,10.0053,0,0,0,12,2.2467Z" />
            </svg>
            <span class="hidden font-semibold sm:block">
              Star on Github
            </span>
          </a>
          <a
            target="_blank"
            class="inline-flex items-center gap-2 p-2 text-gray-500 rounded dark:text-gray-400 dark:hover:text-gray-500 hover:text-gray-400 group"
            href="https://twitter.com/Web3dAppCamp"
          >
            <svg
              class="w-5 h-5 fill-gray-500"
              xmlns="http://www.w3.org/2000/svg"
              data-name="Layer 1"
              viewBox="0 0 24 24"
            >
              <path d="M22,5.8a8.49,8.49,0,0,1-2.36.64,4.13,4.13,0,0,0,1.81-2.27,8.21,8.21,0,0,1-2.61,1,4.1,4.1,0,0,0-7,3.74A11.64,11.64,0,0,1,3.39,4.62a4.16,4.16,0,0,0-.55,2.07A4.09,4.09,0,0,0,4.66,10.1,4.05,4.05,0,0,1,2.8,9.59v.05a4.1,4.1,0,0,0,3.3,4A3.93,3.93,0,0,1,5,13.81a4.9,4.9,0,0,1-.77-.07,4.11,4.11,0,0,0,3.83,2.84A8.22,8.22,0,0,1,3,18.34a7.93,7.93,0,0,1-1-.06,11.57,11.57,0,0,0,6.29,1.85A11.59,11.59,0,0,0,20,8.45c0-.17,0-.35,0-.53A8.43,8.43,0,0,0,22,5.8Z" />
            </svg>
            <span class="hidden font-semibold sm:block">
              Follow us
            </span>
          </a>
          <.color_scheme_switch />
        </div>
      </nav>
      <.container>
        <a href="https://github.com/WeLightProject/Web3-dApp-Camp/tree/main/move-dapp/my-library">
          <.h2 underline label="Library Contract (Click to See SourceCode)" />
        </a>
        <.form let={f} for={:lib}>

          <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div>
              <.form_label form={f} field={:address_of_library} />
              <.text_input  form={f} field={:addr_input} value="0x1168e88ffc5cec53b398b42d61885bbb" />
              <.form_field_error form={f} field={:addr_input} class="mt-1" />
              <br>
              <.button color="secondary" label="Query" variant="outline" />
            </div>

          </div>
        </.form>
        <br>
        <%= if(assigns[:book_res_status] == :ok) do %>
          <%= if(is_nil(assigns[:books])) do%>
            no books now.
          <% else %>
            <%= for book <- @books do%>
              <p><b>Book Id: </b><%= book.id %></p>
              <p><b>Book Name: </b><%= book.name %></p>
              <p><b>Book Link: </b><%= book.link %></p>
              <hr>
            <% end %>
          <% end %>
        <% else %>
          <!--error status-->
          no books now 😁.
        <% end %>
      </.container>
      <br>
      <.container>
      <a href="https://github.com/WeLightProject/Web3-dApp-Camp/tree/main/move-dapp/eth-sig-verifier">
        <.h2 underline label="EthSigVerifier Contract (Click to See SourceCode)" />
      </a>
        <.form let={f} for={:eth_sig_verfier}>
            <.form_label form={f} field={:signature} />
            <.text_input  form={f} field={:signature_input} value="90a938f7457df6e8f741264c32697fc52f9a8f867c52dd70713d9d2d472f2e415d9c94148991bbe1f4a1818d1dff09165782749c877f5cf1eff4ef126e55714d1c" />
            <.form_label form={f} field={:addr} />
            <.text_input  form={f} field={:addr_input} value="29c76e6ad8f28bb1004902578fb108c507be341b" />
            <.form_label form={f} field={:msg} />
            <.text_input  form={f} field={:msg_input} value="b453bd4e271eed985cbab8231da609c4ce0a9cf1f763b6c1594e76315510e0f1" />
            <br>

          <.button color="secondary" label="Verify" variant="outline" />
        </.form>
        <%= if(assigns[:sig_res_status] == :ok) do %>
          <b>Verify Result: </b> <%= @sig_verify_result %>
        <% end %>
      </.container>

    </div>
    """
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: "/live")}
  end

  def handle_event("close_slide_over", _, socket) do
    {:noreply, push_patch(socket, to: "/live")}
  end
end
