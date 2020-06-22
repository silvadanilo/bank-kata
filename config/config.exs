import Config

config :bank, clock_api: Bank.Boundary.Clock

import_config "#{Mix.env()}.exs"
