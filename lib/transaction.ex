defmodule Bank.AccountService.Transaction do
  @moduledoc false

  alias __MODULE__

  defstruct [:operation, :amount, :occured_at, :new_balance]

  def deposit(balance, amount) do
    new_balance = balance + amount

    %Transaction{
      operation: :deposit,
      amount: amount,
      occured_at: clock_api().now(),
      new_balance: new_balance
    }
  end

  def withdraw(balance, amount) do
    new_balance = balance - amount

    %Transaction{
      operation: :withdraw,
      amount: amount,
      occured_at: clock_api().now(),
      new_balance: new_balance
    }
  end

  def formatted_list(transaction = %Transaction{}) do
    [
      format_date(transaction.occured_at),
      format_operation(transaction.operation, transaction.amount),
      transaction.new_balance |> Integer.to_string()
    ]
  end

  defp format_operation(:withdraw, amount) do
    "-" <> Integer.to_string(amount)
  end
  defp format_operation(:deposit, amount) do
    Integer.to_string(amount)
  end

  defp format_date(date) do
    day = date.day |> Integer.to_string() |> String.pad_leading(2, "0")
    month = date.month |> Integer.to_string() |> String.pad_leading(2, "0")
    year = date.year |> Integer.to_string()

    "#{day}/#{month}/#{year}"
  end

  defp clock_api() do
    Application.get_env(:bank, :clock_api)
  end
end
