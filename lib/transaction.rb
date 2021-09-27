class Transaction

  attr_reader :credit, :debit, :date, :balance

  def initialize(balance)
    @date = Time.now
    @balance = balance
  end

  def deposit(amount)
    @credit = amount
  end 

  def withdrawal(amount)
    @debit = amount
  end

end
