require_relative 'transaction'

class Account

  def initialize(transaction = Transaction)
    @transaction = transaction
    @transactions = []
  end

  def current_balance()
    credit = @transactions.map { |transaction| transaction.credit }.sum
    debit = @transactions.map { |transaction| transaction.debit }.sum
    credit - debit
  end

  def deposit(amount)
    new_transaction = @transaction.new(current_balance)
    new_transaction.deposit(amount)
    @transactions.push(new_transaction)
  end

  def withdraw(amount)
    new_transaction = @transaction.new(current_balance)
    new_transaction.withdraw(amount)
    @transactions.push(new_transaction)
  end

end
