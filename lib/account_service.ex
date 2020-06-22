defmodule Bank.AccountService do
  @moduledoc """
  Documentation for `AccountService`.
  """

  alias __MODULE__
  alias Bank.AccountService.Transaction

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
    ["Date", "Amount", "Balance"]
    |> add_history(account)
    |> to_table()
  end

  defp add_history(header, account) do
    [header | Enum.map(account.history, &Transaction.formatted_list/1)]
  end

  defp to_table(statement) do
    statement
    |> Enum.map(&format_history_line/1)
    |> Enum.join("\n")
  end

  defp apply_transaction(account, transaction = %Transaction{}) do
    account
    |> Map.replace!(:current_balance, transaction.new_balance)
    |> Map.update!(:history, fn history -> [transaction | history] end)
  end

  defp format_history_line([date, amount, balance]) do
    [
      date |> String.pad_trailing(10, " "),
      amount |> String.pad_trailing(6, " "),
      balance |> String.pad_trailing(7, " "),
    ]
    |> Enum.join(" || ")
  end

  def balance(%{current_balance: balance}) do
    balance
  end
end
