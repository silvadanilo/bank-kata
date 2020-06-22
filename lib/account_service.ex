defmodule Bank.AccountService do
  @moduledoc """
  Documentation for `AccountService`.
  """

  alias __MODULE__
  alias Bank.AccountService.Transaction
  alias Bank.Helper.TableFormat

  defstruct [initial_balance: 0, current_balance: 0, history: []]

  def open(initial_balance \\ 0) do
    %AccountService{
      initial_balance: initial_balance,
      current_balance: initial_balance,
      history: []
    }
  end

  def deposit(account, amount) do
    apply_transaction(account, Transaction.deposit(account.current_balance, amount))
  end

  def withdraw(account, amount) do
    apply_transaction(account, Transaction.withdraw(account.current_balance, amount))
  end

  def print_statement(account) do
    TableFormat.new(" || ")
    |> TableFormat.with_headers(["Date", "Amount", "Balance"])
    |> TableFormat.with_content(Enum.map(account.history, &Transaction.to_list/1))
    |> TableFormat.column_widths([10, 6, 7])
    |> TableFormat.print()
  end

  defp apply_transaction(account, transaction = %Transaction{}) do
    account
    |> Map.replace!(:current_balance, transaction.new_balance)
    |> Map.update!(:history, fn history -> [transaction | history] end)
  end

  def balance(%{current_balance: balance}) do
    balance
  end
end
