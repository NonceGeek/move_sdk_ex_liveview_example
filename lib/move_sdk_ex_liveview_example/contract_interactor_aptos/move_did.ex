defmodule MoveSDKExLiveviewExample.ContractInteractorAptos.MoveDID do
  @moduledoc """
    See MOVE Contract in: \n
    > https://github.com/WeLightProject/Web3-dApp-Camp/tree/main/move-dapp/my-library \n
    Short Description: It's a contract about Library and Books to show how the resources working in MOVE Lang.
  """
  alias Web3MoveEx.Aptos.RPC
  alias Web3MoveEx

  def get_resource(addr, :move_did) do
    contract_addr = Constants.get_contracts_aptos(:move_did)

    {:ok, client} =
      Constants.get_aptos_endpoint()
      |> RPC.connect()
    client
    |> RPC.get_account_resources(addr)
    |> handle_res(contract_addr)
  end

  def handle_res({:ok, res}, contract_addr), do: {:ok, do_handle_res(res, contract_addr)}
  def handle_res({:error, res}, _contract_addr), do: {:error, res}

  def do_handle_res(res, contract_addr) do
    res
    |> Enum.filter(fn elem ->
      elem.type == build_addr_aggr(contract_addr) or elem.type == build_endpoint_aggr(contract_addr)
    end)
  end

  def build_addr_aggr(contract_addr) do
    "#{contract_addr}::addr_aggregator::AddrAggregator"
  end

  def build_endpoint_aggr(contract_addr) do
    "#{contract_addr}::endpoint_aggregator::EndpointAggregator"
  end
end
