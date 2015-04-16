use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :tetris, Tetris.Endpoint,
  secret_key_base: "sVD2bTi4Tbo7RgPfNnfmsyFcb/ksSX8+GuuI2bnSogYAdMvImdFb0hRqsv1IIGZK"

# Configure your database
config :tetris, Tetris.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tetris_prod"
