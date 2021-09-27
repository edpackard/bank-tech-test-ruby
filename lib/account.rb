require 'transaction'

class Account

  def initialize(transaction = Transaction)
    @transaction = transaction
  end

  def current_balance()
    return 0
  end

  def deposit(amount)
    @transaction.new.deposit(amount)
  end

  def withdraw(amount)
    @transaction.new.withdraw(amount)
  end

end
