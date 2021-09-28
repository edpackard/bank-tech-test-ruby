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
    record = new_transaction(amount)
    record.deposit(amount)
    @transactions.push(record)
  end

  def withdraw(amount)
    record = new_transaction(-amount)
    record.withdraw(amount)
    @transactions.push(record)
  end

  def statement(printer = Printer.new)
    printer.statement(@transactions)
  end

  private

  def new_transaction(amount)
    @transaction.new(current_balance+amount)
  end
end
