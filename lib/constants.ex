defmodule Constants do
  def get_starcoin_endpoint() do
    Application.fetch_env!(:move_sdk_ex_liveview_example, :starcoin_endpoint)
  end

  def get_contracts(name) do
    :move_sdk_ex_liveview_example
    |> Application.fetch_env!(:contract_addrs)
    |> Map.fetch!(name)
  end
end
