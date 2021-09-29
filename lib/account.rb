require_relative 'statement'
require_relative 'transaction'

class Account

  def initialize(transaction = Transaction)
    @transaction = transaction
    @transactions = []
  end

  def current_balance
    @transactions.map { |record| record.credit - record.debit }.sum
  end

  def deposit(amount)
    new_transaction(amount)
    "#{amount} deposited successfully"
  end

  def withdraw(amount)
    new_transaction(amount, true)
    "#{amount} withdrawn successfully"
  end

  def statement(statement = Statement.new)
    statement.printer(@transactions); nil
  end

  private

  def new_transaction(amount, withdraw = false)
    validity_check(amount)
    record = @transaction.new(current_balance)
    withdraw ? record.withdraw(amount) : record.deposit(amount)
    @transactions.push(record)
  end

  def validity_check(amount)
    raise 'Please enter a valid amount' unless is_valid?(amount)
  end

  def is_valid?(amount)
    amount.positive?
  end

end
