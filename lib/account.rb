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
    record = new_transaction
    record.deposit(amount)
    @transactions.push(record)
  end

  def withdraw(amount)
    record = new_transaction
    record.withdraw(amount)
    @transactions.push(record)
  end

  private

  def new_transaction
    @transaction.new(current_balance)
  end
end
