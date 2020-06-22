defmodule Bank.Boundary.Clock do
  @moduledoc """
  Documentation for `Clock`.
  """

  def now() do
    ~U[2010-05-21 10:58:30.261748Z]
    # DateTime.now("Etc/UTC")
  end
end
