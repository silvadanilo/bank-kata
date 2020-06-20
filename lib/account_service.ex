defmodule Bank.AccountService do
  @moduledoc """
  Documentation for `AccountService`.
  """

  def new(initial_balance) do
    %{
      initial_balance: initial_balance,
      transactions: []
    }
  end

  def deposit(account, amount) do
    %{
      initial_balance: account.initial_balance,
      transactions: [
        %{deposit: amount}
      ]
    }
  end

  def withdraw do
  end

  def printStatement do
  end

  #FIXME: remove me
  def balance(account) do
    Enum.reduce(
      account.transactions,
      account.initial_balance,
      fn transaction, balance -> apply_transaction(balance, transaction) end
    )
  end

  def apply_transaction(balance, %{deposit: amount}) do
    balance + amount
  end
end
