require 'account'

describe Account do

  let(:transaction_class) { double :transaction_class }
  let(:transaction_instance) { double :transaction_instance, credit: 10.00 }

  subject { Account.new(transaction_class) }

  before(:each) do
    allow(transaction_class).to receive(:new).and_return(transaction_instance)
  end

  it "starts with a balance of zero" do
    expect(subject.current_balance).to eq(0)
  end

  it "calls transaction deposit function" do
    expect(transaction_instance).to receive(:deposit).with(100.00)
    subject.deposit(100.00)  
  end

  it "calls transaction withdraw function" do
    expect(transaction_instance).to receive(:withdraw).with(100.00)
    subject.withdraw(100.00)
  end
  
  it "calculates current balance" do
    allow(transaction_instance).to receive(:deposit).with(10.00).and_return([@credit = 10.00])
    subject.deposit(10.00)
    expect(subject.current_balance).to eq(10.00)
  end

end
