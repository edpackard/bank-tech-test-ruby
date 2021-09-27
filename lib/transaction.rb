class Transaction

  attr_reader :credit, :debit, :date

  def initialize
    @date = Time.now
  end

  def deposit(amount)
    @credit = amount
  end 

  def withdrawal(amount)
    @debit = amount
  end

end
