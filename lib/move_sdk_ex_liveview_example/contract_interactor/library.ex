defmodule MoveSDKExLiveviewExample.ContractInteractor.Library do
  @moduledoc """
    See MOVE Contract in: \n
    > https://github.com/WeLightProject/Web3-dApp-Camp/tree/main/move-dapp/my-library \n
    Short Description: It's a contract about Library and Books to show how the resources working in MOVE Lang.
  """
  alias Web3MoveEx.Starcoin.Caller
  alias Web3MoveEx.Starcoin.Caller.Contract

  def get_resource(addr, :library) do
    Constants.get_starcoin_endpoint()
    |> Contract.get_resource(
      addr,
      book_struct()
    )
    |> handle_res()
  end

  def book_struct() do
    contract_addr()
    |> Caller.build_namespace("MyLibraryV5","Library")
  end

  def contract_addr() do
    Constants.get_contracts(:library)
  end

  def handle_res({:error, payload}), do: {:error, inspect(payload)}
  def handle_res({:ok, %{result: result}}) do
    do_handle_res(result)

  end

  def do_handle_res(nil), do: {:ok, nil}
  def do_handle_res(result) do
    %{value: [["books", %{Vector: vec_list}]]} = result
    {
      :ok,
      vec_list
      |> Enum.map(&(handle_book(&1)))
    }
  end

  def handle_book(%{Struct: %{value: values}}) do
    values
    |> Enum.map(&(List.to_tuple(&1)))
    |> Enum.map(fn {key, value} ->
      {key, Web3MoveEx.TypeTranslator.parse_type_in_move(value)}
    end)
    |> Enum.into(%{})
    |> ExStructTranslator.to_atom_struct()

  end

end
