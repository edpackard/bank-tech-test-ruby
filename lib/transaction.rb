class Transaction

  attr_reader :credit, :debit

  def deposit(amount)
    @credit = amount
  end 

  def withdrawal(amount)
    @debit = amount
  end

end