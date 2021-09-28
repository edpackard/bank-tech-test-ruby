require 'account'

describe 'feature test' do

  time = Time.now
  date = time.strftime("%d/%m/%Y")
  
  it 'makes several transactions' do
    account = Account.new
    account.deposit(10.00)
    account.withdraw(5.00)
    account.deposit(2.50)
    expect(account.current_balance).to eq(7.50)
  end

  it 'makes transactions and prints a statement' do
    account = Account.new
    account.deposit(10.00)
    account.withdraw(5.00)
    account.deposit(2.50)
    account.deposit(20.00)
    account.withdraw(3.00)
    account.deposit(500.00)
    expected_output =
    "date || credit || debit || balance\n"\
    "#{date} || 500.00 || || 524.50\n"\
    "#{date} || || 3.00 || 24.50\n"\
    "#{date} || 20.00 || || 27.50\n"\
    "#{date} || 2.50 || || 7.50\n"\
    "#{date} || || 5.00 || 5.00\n"\
    "#{date} || 10.00 || || 10.00\n"
    expect { account.statement }.to output(expected_output).to_stdout
  end

end
