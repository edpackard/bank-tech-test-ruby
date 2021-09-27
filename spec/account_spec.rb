require 'account'

describe Account do

  let(:transaction_class) { double :transaction_class }
  let(:transaction_instance) { double :transaction_instance }

  subject { Account.new(transaction_class) }

  before(:each) do
    allow(transaction_class).to receive(:new).and_return(transaction_instance)
  end
  
  it "starts with a balance of zero" do
    expect(subject.current_balance).to eq(0)
  end

  it "can call transaction deposit function" do
    expect(transaction_instance).to receive(:deposit).with(100.00)
    subject.deposit(100.00)  
  end

  it "can call transaction withdraw function" do
    expect(transaction_instance).to receive(:withdraw).with(100.00)
    subject.withdraw(100.00)
  end

end
