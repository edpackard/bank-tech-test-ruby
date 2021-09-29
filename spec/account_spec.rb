require 'account'

describe Account do

  let(:statement_instance) { double :statement_instance }
  let(:transaction_class) { double :transaction_class }
  let(:transaction_instance) { double :transaction_instance }
  let(:transaction_instance_credit) { double :transaction_instance, credit: 10.00, debit: 0.0 }
  let(:transaction_instance_debit) { double :transaction_instance, credit: 0.0, debit: 10.00 }
 
  subject { Account.new(transaction_class, statement_instance) }

  before(:each) do
    allow(transaction_class).to receive(:new).and_return(transaction_instance)
  end

  context "basic functionality" do
    
    it "starts with a balance of zero" do
      expect(subject.current_balance).to eq(0)
    end

    it "handles deposits" do
      expect(transaction_instance).to receive(:deposit).with(100.00)
      subject.deposit(100.00)  
    end

    it "handles withdrawals" do
      expect(transaction_instance).to receive(:withdraw).with(100.00)
      subject.withdraw(100.00)
    end

    it 'sends current balance to transaction instance' do
      allow(transaction_instance).to receive(:deposit).with(100.00)
      expect(transaction_class).to receive(:new).with(0)
      subject.deposit(100.00)
    end
  end

  context "error handling and edge cases" do
  
    it "rejects negative numeric input for withdraw" do
      expect { subject.withdraw(-10.00) }.to raise_error(Account::ERROR)
    end

    it "rejects negative numeric input for deposit" do
      expect { subject.deposit(0) }.to raise_error(Account::ERROR)
    end

    it "rejects zero input for withdraw" do
      expect { subject.withdraw(0) }.to raise_error(Account::ERROR)

    end

    it "rejects zero input for deposit" do
      expect { subject.deposit(-10.00) }.to raise_error(Account::ERROR)
    end

    it "rejects non-numeric inputs for withdraw" do
      expect { subject.withdraw("10.00") }.to raise_error(Account::ERROR)
    end

    it "rejects non-numeric inputs for deposit" do
      expect { subject.deposit("10.00") }.to raise_error(Account::ERROR)
    end
   
    it "rejects empty input for withdraw" do
      expect { subject.withdraw(nil) }.to raise_error(Account::ERROR)
    end

    it "rejects empty input for deposit" do
      expect { subject.deposit(nil) }.to raise_error(Account::ERROR)
    end

    it "rejects non-currency decimals" do
      expect { subject.deposit(12.345) }.to raise_error(Account::ERROR)
    end

    it "rejects non-currency decimals" do
      expect { subject.withdraw(65.4321) }.to raise_error(Account::ERROR)
    end
  end
    
  context "balance calculation functionality" do 

    it "adjusts current balance after deposit" do
      allow(transaction_class).to receive(:new).and_return(transaction_instance_credit)
      allow(transaction_instance_credit).to receive(:deposit).with(10.00)
      expect { subject.deposit(10.00) }.to change { subject.current_balance }.by(10.00)
    end

    it "adjusts balance after withdrawal" do
      allow(transaction_class).to receive(:new).and_return(transaction_instance_debit)
      allow(transaction_instance_debit).to receive(:withdraw).with(10.00)
      expect { subject.withdraw(10.00) }.to change { subject.current_balance }.by(-10.00)
    end
  end

  context "#statement" do

    it "calls printer statement function with transactions array" do
      allow(transaction_instance).to receive(:withdraw).with(20.00)
      subject.withdraw(20.00)
      expect(statement_instance).to receive(:printer).with([transaction_instance])
      subject.statement
    end
  end
end
