use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Todolix.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_todolix_key",
  session_secret: "J(K$Z%&2ZG@QKO+RTR&1OL$X@+^USM6G2V8SY8=E3C=EC9$ZP8D(Z1^C9#_1+6GULYKD+3+GMHUZ8"

config :logger, :console,
  level: :info,
  metadata: [:request_id]

