# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y58gPfpq8rqzT9KTCnrOy0z1QwVaUyjsA6Z+4iz18LhmGrKZb/UMW1KKzHLIFIfw",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "P9Wps1pg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Pow
config :pow, Pow.Postgres.Store, repo: App.Repo

config :app, :pow,
  user: App.Users.User,
  repo: App.Repo,
  extensions: [PowResetPassword],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: AppWeb.Pow.Mailer,
  routes_backend: AppWeb.Pow.Routes,
  web_module: AppWeb,
  cache_store_backend: Pow.Postgres.Store

config :app, :pow_assent,
  providers: [
    facebook: [
      client_id: System.get_env("FACEBOOK_CLIENT_ID"),
      client_secret: System.get_env("FACEBOOK_SECRET"),
      strategy: Assent.Strategy.Facebook
    ]
  ]

config :tesla, adapter: Tesla.Adapter.Hackney

# Add cron jobs here
config :app, App.Scheduler,
  jobs: [
    # {"0 0 * * SUN", {App.WeeklyDigestCron, :init, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
