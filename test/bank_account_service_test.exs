defmodule Bank.AccountServiceTest do
  use ExUnit.Case

  alias Bank.AccountService

  test "new returns an AccountService" do
    assert %{initala_balance: 10, transactions: []} == AccountService.new(10)
  end

  test "A client can deposit money" do
    #Given an empty account
    account = AccountService.new(0)

    #When a client deposit money
    AccountService.deposit(account, 1000)

    #Then the balance is changed
    1000 == AccountService.balance(account)
  end
end
