require_relative 'transaction'

class Account

  def initialize(transaction = Transaction)
    @transaction = transaction
    @transactions = []
  end

  def current_balance()
    @transactions.map { |transaction| transaction.credit }.sum
  end

  def deposit(amount)
    new_transaction = @transaction.new(current_balance)
    new_transaction.deposit(amount)
    @transactions.push(new_transaction)
  end

  def withdraw(amount)
    @transaction.new.withdraw(amount)
  end

end
