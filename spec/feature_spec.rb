require 'account'

describe 'feature test' do
  
  it 'makes several transactions' do
    account = Account.new
    account.deposit(10.00)
    account.withdraw(5.00)
    account.deposit(2.50)
    expect(account.current_balance).to eq(7.50)
  end

end
