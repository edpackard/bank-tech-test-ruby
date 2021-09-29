require_relative 'statement'
require_relative 'transaction'

class Account

  ERROR = 'Please enter a valid amount'

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
    raise ERROR unless valid?(amount)
  end

  def valid?(amount)
    (amount.is_a? Numeric) && amount.positive? && ((amount * 100) % 1).zero?
  end

end
