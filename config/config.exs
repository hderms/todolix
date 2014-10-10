# This file is responsible for configuring your application
use Mix.Config

# Note this file is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project.

config :phoenix, Todolix.Router,
  port: System.get_env("PORT"),
  ssl: false,
  static_assets: true,
  cookies: true,
  session_key: "_todolix_key",
  session_secret: "J(K$Z%&2ZG@QKO+RTR&1OL$X@+^USM6G2V8SY8=E3C=EC9$ZP8D(Z1^C9#_1+6GULYKD+3+GMHUZ8",
  catch_errors: true,
  debug_errors: false,
  error_controller: Todolix.PageController

config :phoenix, :code_reloader,
  enabled: false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. Note, this must remain at the bottom of
# this file to properly merge your previous config entries.
import_config "#{Mix.env}.exs"
