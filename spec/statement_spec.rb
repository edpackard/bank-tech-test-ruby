require 'statement'

describe Statement do

  let(:record_1) { double credit: 0.0, debit: 10.00, date: Time.new(2021, 9, 1), balance: -10.00 }
  let(:record_2) { double credit: 20.00, debit: 0.0, date: Time.new(2021, 9, 27), balance: 10.00 }
  let(:record_3) { double credit: 10.00, debit: 0.0, date: Time.new(2021, 9, 28), balance: 20.00 }

  it "prints the header" do
    transactions = []
    expect { subject.printer(transactions) }.to output(Statement::HEADING).to_stdout
  end

  it "prints a statement in correct format" do
    output_string = "28/09/2021 || 10.00 || || 20.00\n"\
      "27/09/2021 || 20.00 || || 10.00\n"\
      "01/09/2021 || || 10.00 || -10.00\n"
    expected_output = Statement::HEADING + output_string
    transactions = [record_1, record_2, record_3]
    expect { subject.printer(transactions) }.to output(expected_output).to_stdout
  end
end
