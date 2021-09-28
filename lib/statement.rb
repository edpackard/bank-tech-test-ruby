class Statement

  HEADING = "date || credit || debit || balance\n"
  DIVIDER = " ||"

  def printer(transactions)
    print HEADING
    transactions.reverse.each do |record|
      print record_string(record)
    end
  end

  private

  def record_string(record)
    "#{date_string(record.date)}"\
    "#{transaction_string(record.credit)}"\
    "#{transaction_string(record.debit)}"\
    "#{number_string(record.balance, true)}"
  end
  
  def date_string(date)
    "#{date.strftime("%d/%m/%Y") + DIVIDER}"
  end

  def transaction_string(transaction)
    "#{transaction.zero? ? DIVIDER : number_string(transaction)}"\
  end

  def number_string(number, is_balance = false)
    string = "#{sprintf(' %.2f', number)}" 
    is_balance ? "#{string}\n" : "#{string + DIVIDER}"
  end

end