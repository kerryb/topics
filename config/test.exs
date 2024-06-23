import Config

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# In test we don't send emails
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :topics, Topics.Mailer, adapter: Swoosh.Adapters.Test

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
config :topics, Topics.Repo,
  hostname: "localhost",
  database: "topics_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :topics, TopicsWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "vbNiCd4PF3u8V2Ktp+0KBktqLH7fqjs/QUorutFakUutBoy5ESGxdjLvMQLoGTxb",
  # We don't run a server during test. If one is required,
  # you can enable the server option below.
  server: false

config :topics, :ldap,
  host: "ipa.demo1.freeipa.org",
  port: 389,
  bind_dn_pattern: "uid=~s,cn=users,cn=accounts,dc=demo1,dc=freeipa,dc=org",
  use_ssl: false
