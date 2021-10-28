# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :poetic,
  ecto_repos: [Poetic.Repo]

# Configures the endpoint
config :poetic, PoeticWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZmIp1SyzvAeswAEpR5SIPsez0Y6N4M3OjkbKBzjRebo+loQN66JHNO0IZgqY6Qeu",
  render_errors: [view: PoeticWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Poetic.PubSub,
  live_view: [signing_salt: "PrzEbJ72"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

#this is only if we want to use the system in production
config :poetic,
  uploads_directory: System.get_env("POETIC_UPLOADS_DIRECTORY") || "/uploads"

config :poetic, PoeticWeb.Auth.Guardian,
  issuer: "poetic",
  secret_key: "0T5Oj5E5/rrrl3d6vv0kcAmfU5TaCKlTRvuZuCE4Gxbbv2ykEAeOHuinL12o6eJO"