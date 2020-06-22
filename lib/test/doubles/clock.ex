defmodule Bank.Test.Clock do
  @moduledoc """
  Documentation for `Clock`.
  """

  @table :clock

  def init() do
    :ets.new(@table, [:set, :public, :named_table])
  end

  def now() do
    :ets.lookup(@table, :now) |> Keyword.get(:now)
  end

  def now_is(next_date) do
    :ets.insert(@table, {:now, next_date})
  end
end
