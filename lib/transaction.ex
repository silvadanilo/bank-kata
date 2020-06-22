defmodule Bank.AccountService.Transaction do
  @moduledoc false

  alias __MODULE__

  defstruct [:operation, :amount, :occured_at, :new_balance]

  def deposit(balance, amount) do
    occured(:deposit, amount, balance + amount)
  end

  def withdraw(balance, amount) do
    occured(:withdraw, amount, balance - amount)
  end

  defp occured(type, amount, new_balance) do
    %Transaction{
      operation: type,
      amount: amount,
      occured_at: clock_api().now(),
      new_balance: new_balance
    }
  end

  def to_list(transaction = %Transaction{}) do
    [
      format_date(transaction.occured_at),
      format_amount(transaction.operation, transaction.amount),
      transaction.new_balance |> Integer.to_string()
    ]
  end

  defp format_amount(type, amount) do
    amount
    |> Integer.to_string()
    |> prepend_symbol(type)
  end
  defp prepend_symbol(amount, :withdraw), do: "-" <> amount
  defp prepend_symbol(amount, :deposit), do: amount

  defp format_date(date) do
    day = date.day |> zero_pad()
    month = date.month |> zero_pad()
    year = date.year |> zero_pad(4)

    "#{day}/#{month}/#{year}"
  end

  defp zero_pad(number, how_many_digits \\ 2) do
    number |> Integer.to_string() |> String.pad_leading(how_many_digits, "0")
  end

  defp clock_api() do
    Application.get_env(:bank, :clock_api)
  end
end
