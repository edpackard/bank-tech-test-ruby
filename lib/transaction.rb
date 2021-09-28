require 'bigdecimal'

class Transaction

  attr_reader :credit, :debit, :date, :balance

  def initialize(balance)
    @date = Time.now
    @balance = balance
    @debit = BigDecimal("0")
    @credit = BigDecimal("0")
  end

  def deposit(amount)
    p amount
    @credit = BigDecimal("#{amount}")
  end 

  def withdraw(amount)
    @debit = BigDecimal("#{amount}")
  end

end
