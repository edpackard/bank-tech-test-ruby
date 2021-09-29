require 'bigdecimal'

class Transaction

  attr_reader :credit, :debit, :date, :balance

  def initialize(balance)
    @date = Time.now
    @balance = BigDecimal("#{balance}")
    @debit = BigDecimal("0")
    @credit = BigDecimal("0")
  end

  def deposit(amount)
    @credit = BigDecimal("#{amount}")
    @balance += @credit
  end 

  def withdraw(amount)
    @debit = BigDecimal("#{amount}")
    @balance -= @debit
  end

end
