# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :move_sdk_ex_liveview_example,
  ecto_repos: [MoveSDKExLiveviewExample.Repo],

  starcoin_endpoint: "http://localhost:9851", # !!Metion: change here to dif network
  aptos_endpoint: "https://fullnode.testnet.aptoslabs.com/v1",
  contract_addrs: %{
    library: "0x1168e88ffc5cec53b398b42d61885bbb",
    eth_sig_verifier: "0x1168e88ffc5cec53b398b42d61885bbb"
  }, # !!Metion: change here to dif contract addr
  contract_addrs_aptos: %{
    move_did: "0x1f9aa0aa17a3c8b02546df9353cdbee47f14bcaf25f5524492a17a8ab8c906ee" # test module
  }

# Configures the endpoint
config :move_sdk_ex_liveview_example, MoveSDKExLiveviewExampleWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: MoveSDKExLiveviewExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MoveSDKExLiveviewExample.PubSub,
  live_view: [signing_salt: "Fd8SWPu3"]



# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :move_sdk_ex_liveview_example, MoveSDKExLiveviewExample.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.50",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :petal_components,
       :error_translator_function,
       {MoveSDKExLiveviewExampleWeb.ErrorHelpers, :translate_error}

config :tailwind,
  version: "3.1.6",
  default: [
    args: ~w(
         --config=tailwind.config.js
         --input=css/app.css
         --output=../priv/static/assets/app.css
       ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
