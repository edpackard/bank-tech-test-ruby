require 'account'
require 'timecop'

describe 'feature test' do

  time = Time.local(2022, 1, 1)
  Timecop.freeze(time)

  it 'makes several transactions' do
    account = Account.new
    account.deposit(10.00)
    account.withdraw(5.00)
    account.deposit(2.50)
    expect(account.current_balance).to eq(7.50)
  end

  it 'makes several transactions and prints a statement' do
    expected_output =
    "date || credit || debit || balance\n"\
    "14/02/2022 || 500.00 || || 524.50\n"\
    "01/02/2022 || || 3.00 || 24.50\n"\
    "01/02/2022 || 20.00 || || 27.50\n"\
    "01/01/2022 || 2.50 || || 7.50\n"\
    "01/01/2022 || || 5.00 || 5.00\n"\
    "01/01/2022 || 10.00 || || 10.00\n"
    account = Account.new
    account.deposit(10.00)
    account.withdraw(5.00)
    account.deposit(2.50)
    time = Time.local(2022, 2, 1)
    Timecop.freeze(time)
    account.deposit(20.00)
    account.withdraw(3.00)
    time = Time.local(2022, 2, 14)
    Timecop.freeze(time)
    account.deposit(500.00)
    expect { account.statement }.to output(expected_output).to_stdout
    Timecop.return
  end
end
