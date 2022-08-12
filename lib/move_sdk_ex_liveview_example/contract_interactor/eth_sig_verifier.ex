defmodule MoveSDKExLiveviewExample.ContractInteractor.EthSigVerifier do
    @moduledoc """
      See MOVE Contract in: \n
      > https://github.com/WeLightProject/Web3-dApp-Camp/tree/main/move-dapp/my-library \n
      Short Description: It's a contract about Library and Books to show how the resources working in MOVE Lang.
    """
    alias Web3MoveEx.Starcoin.Caller
    alias Web3MoveEx.Starcoin.Caller.Contract
    alias  Web3MoveEx.TypeTranslator

    @spec call_func(atom, String.t(), String.t(), String.t()) :: bool
    def call_func(:verify_eth_sig, signature, signer, msg) do
      Constants.get_starcoin_endpoint()
      |>  Contract.call_v2(
          eth_sig_verifier_func(),
          build_params([signature, signer, msg])
      )
      |> handle_res()
    end
    def build_params(params) do
      Enum.map(params, &(TypeTranslator.hex_to_starcoin_byte(&1)))
    end

    def eth_sig_verifier_func() do
      contract_addr()
      |> Caller.build_namespace("EthSigVerifier","verify_eth_sig")
    end

    def contract_addr() do
      Constants.get_contracts(:eth_sig_verifier)
    end

    def handle_res({:ok, %{id: 1, jsonrpc: "2.0", result: [result]}}), do: {:ok, result}
    def handle_res({:error, msg}), do: {:error, inspect(msg)}

  end
