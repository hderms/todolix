use Mix.Config

config :phoenix, Todolix.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false,
  cookies: true,
  session_key: "_todolix_key",
  session_secret: "J(K$Z%&2ZG@QKO+RTR&1OL$X@+^USM6G2V8SY8=E3C=EC9$ZP8D(Z1^C9#_1+6GULYKD+3+GMHUZ8"

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


