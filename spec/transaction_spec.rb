require 'transaction'

describe Transaction do

  subject { Transaction.new(5.00) }

  context 'initialization values' do

    it 'receives an argument which sets transaction balance' do
      new_transaction = Transaction.new(100.00)
      expect(new_transaction.balance).to eq(100.00)
    end

    it 'initializes with the current date' do
      time = Time.now
      allow(Time).to receive(:now).and_return(time)
      new_transaction = Transaction.new(5.00)
      expect(new_transaction.date).to eq(time)
    end

    it 'initializes with zero values for credit and debit' do
      expect(subject.credit).to eq(0)
      expect(subject.debit).to eq(0)
    end

    it 'initializes with BigDecimal values for accuracy' do
      expect(subject.credit).to be_a BigDecimal
      expect(subject.debit).to be_a BigDecimal
    end

  end

  context '#deposit' do
  
    it 'records a deposit as a credit' do 
      subject.deposit(10.00)
      expect(subject.credit).to eq(10.00)
    end

    it 'records credit as a BigDecimal' do
      subject.deposit(10.00)
      expect(subject.credit).to be_a BigDecimal
    end

  end
  
  context '#withdrawal' do
  
    it 'records a withdrawal as a debit' do
      subject.withdraw(10.00)
      expect(subject.debit).to eq(10.00)
    end

    it 'records a withdrawal as a BigDecimal' do
      subject.withdraw(10.00)
      expect(subject.debit).to be_a BigDecimal
    end

  end

end
