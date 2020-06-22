defmodule Bank.AccountServiceTest do
  use ExUnit.Case

  alias Bank.AccountService
  alias Bank.Test.Clock

  setup do
    Clock.init()
    Clock.now_is(~U[2012-01-10 00:00:00.000000Z])
    :ok
  end

  test "new returns an AccountService" do
    assert %AccountService{
      initial_balance: 10,
      current_balance: 10,
      history: []
    } == AccountService.open(10)
  end

  test "A client can deposit money" do
    balance =
      AccountService.open(20)
      |> AccountService.deposit(1000)
      |> AccountService.deposit(2000)
      |> AccountService.withdraw(500)
      |> AccountService.balance()

    assert 2520 == balance
  end

  test "Print statement returns a formatted table" do
    statement =
      AccountService.open()
      |> AccountService.deposit(1000)
      |> and_now_is(~U[2012-01-13 00:00:00.000000Z])
      |> AccountService.deposit(2000)
      |> and_now_is(~U[2012-01-14 00:00:00.000000Z])
      |> AccountService.withdraw(500)
      |> AccountService.print_statement()

    # Avoided heredoc because there are trailing spaces at the end of lines and some editor might trim them
    expected_statement =
      "Date       || Amount || Balance\n" <>
      "14/01/2012 || -500   || 2500   \n" <>
      "13/01/2012 || 2000   || 3000   \n" <>
      "10/01/2012 || 1000   || 1000   "

    assert expected_statement == statement
  end

  defp and_now_is(account, date) do
    Clock.now_is(date)
    account
  end
end
