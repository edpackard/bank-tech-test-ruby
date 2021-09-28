require_relative 'printer'
require_relative 'transaction'

class Account

  def initialize(transaction = Transaction)
    @transaction = transaction
    @transactions = []
  end

  def current_balance()
    @transactions.map { |record| record.credit - record.debit }.sum
  end

  def deposit(amount)
    new_transaction(amount)
    "#{amount} deposited successfully"
  end

  def withdraw(amount)
    new_transaction(-amount, true)
    "#{amount} withdrawn successfully"
  end

  def statement(printer = Printer.new)
    printer.statement(@transactions); nil
  end

  private

  def new_transaction(amount, withdrawal = false)
    record = @transaction.new(current_balance + amount)
    withdrawal ? record.withdraw(amount.abs) : record.deposit(amount)
    @transactions.push(record)
  end

end