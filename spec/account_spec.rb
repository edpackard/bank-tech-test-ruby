require 'account'

describe Account do
  let(:printer_instance) { double :printer_instance }
  let(:transaction_class) { double :transaction_class }
  let(:transaction_instance) { double :transaction_instance }
  let(:transaction_instance_credit) { double :transaction_instance, credit: 10.00, debit: 0.0 }
  let(:transaction_instance_debit) { double :transaction_instance, credit: 0.0, debit: 10.00 }
 
  subject { Account.new(transaction_class) }

  context "basic functionality" do
    
    before(:each) do
       ## can change/add to this to specify transaction_class receiving curr balance +/- amount?
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

  end
    
  context "balance calculation functionality" do 

    it "adjusts balance with deposit" do
      allow(transaction_class).to receive(:new).and_return(transaction_instance_credit)
      allow(transaction_instance_credit).to receive(:deposit).with(10.00)
      expect { subject.deposit(10.00) }.to change { subject.current_balance }.by(10.00)
    end

    it "adjusts balance with withdrawal" do
      allow(transaction_class).to receive(:new).and_return(transaction_instance_debit)
      allow(transaction_instance_debit).to receive(:withdraw).with(10.00)
      expect { subject.withdraw(10.00) }.to change { subject.current_balance }.by(-10.00)
    end

    it "calculates accurately using BigDecimal" do
      allow(transaction_class).to receive(:new).and_return(transaction_instance_debit)
      allow(transaction_instance_debit).to receive(:withdraw).with(10.00)
    end

  end

  context "#statement" do

    before(:each) do
      allow(transaction_class).to receive(:new).and_return(transaction_instance)
      allow(transaction_instance).to receive(:withdraw).with(20.00)
      subject.withdraw(20.00)
    end

    it "calls printer statement function with transactions array" do
      expect(printer_instance).to receive(:statement).with([transaction_instance])
      subject.statement(printer_instance)
    end
  end
end
