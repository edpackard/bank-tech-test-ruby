class Printer

  def statement(transactions)
    string = ""
    string += "date || credit || debit || balance\n" 
    transactions.reverse.each do |record|
      string += "#{record.date.strftime("%d/%m/%Y")} ||"\
        "#{sprintf(' %.2f', record.credit) if record.credit != 0} ||"\
        "#{sprintf(' %.2f', record.debit) if record.debit != 0} ||"\
        "#{sprintf(' %.2f', record.balance)}\n"
    end
    print string
  end

end