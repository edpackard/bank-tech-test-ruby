require 'statement'

describe Statement do

  let(:transaction_1) { double :transaction_instance, credit: 0.0, debit: 10.00, date: Time.new(2021, 9, 1), balance: -10.00 }
  let(:transaction_2) { double :transaction_instance, credit: 20.00, debit: 0.0, date: Time.new(2021, 9, 27), balance: 10.00 }
  let(:transaction_3) { double :transaction_instance, credit: 10.00, debit: 0.0, date: Time.new(2021, 9, 28), balance: 20.00 }


  it "prints the header" do
    transactions = ([])
    expect { subject.printer(transactions) }.to output(Statement::HEADING).to_stdout
  end

  it "prints a statement" do
    expected_output =
      "28/09/2021 || 10.00 || || 20.00\n"\
      "27/09/2021 || 20.00 || || 10.00\n"\
      "01/09/2021 || || 10.00 || -10.00\n"
    transactions = [transaction_1, transaction_2, transaction_3]
    expect { subject.printer(transactions) }.to output(Statement::HEADING + expected_output).to_stdout
  end

end