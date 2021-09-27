class Transaction

  attr_reader :credit, :debit, :date, :balance

  def initialize(balance)
    @date = Time.now
    @balance = balance
    @debit = 0
    @credit = 0
  end

  def deposit(amount)
    @credit = amount
  end 

  def withdraw(amount)
    @debit = amount
  end

end
