use Mix.Config

# Configure your database
config :app, App.Repo,
  username: System.get_env("POSTGRES_USERNAME"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: System.get_env("POSTGRES_DATABASE"),
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# config :app, App.Repo,
#   username: System.get_env("POSTGRES_USERNAME"),
#   password: System.get_env("POSTGRES_PASSWORD"),
#   database: System.get_env("POSTGRES_DATABASE"),
#   show_sensitive_data_on_connection_error: true,
#   socket_dir: "/tmp/cloudsql/crisis-heroes:australia-southeast1:crisis-heroes",
#   pool_size: 15

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :app, AppWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :app, AppWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/app_web/(live|views)/.*(ex)$",
      ~r"lib/app_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :app, App.Mailer, adapter: Bamboo.LocalAdapter
config :app, AppWeb.Pow.Mailer, adapter: Bamboo.LocalAdapter
