require 'timecop'
require 'transaction'

describe Transaction do

  subject { Transaction.new(0) }

  context 'initialization values' do

    it 'sets transaction balance with received argument' do
      new_transaction = Transaction.new(100.00)
      expect(new_transaction.balance).to eq(100.00)
    end

    it 'sets the balance as a BigDecimal' do
      new_transaction = Transaction.new(200.00)
      expect(new_transaction.balance).to be_a BigDecimal
    end

    it 'initializes with the current date' do
      time = Time.now
      Timecop.freeze(time)
      new_transaction = Transaction.new(5.00)
      expect(new_transaction.date).to eq(time)
      Timecop.return
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
  
    it 'records deposit as a credit' do 
      subject.deposit(10.00)
      expect(subject.credit).to eq(10.00)
    end

    it 'records credit as a BigDecimal' do
      subject.deposit(10.00)
      expect(subject.credit).to be_a BigDecimal
    end

    it 'updates the balance' do
      expect { subject.deposit(10.00) }.to change { subject.balance }.by(10.00)
      expect(subject.balance).to be_a BigDecimal
    end
  end
  
  context '#withdrawal' do
  
    it 'records withdrawal as a debit' do
      subject.withdraw(10.00)
      expect(subject.debit).to eq(10.00)
    end

    it 'records a withdrawal as a BigDecimal' do
      subject.withdraw(10.00)
      expect(subject.debit).to be_a BigDecimal
    end

    it 'updates the balance' do
      expect { subject.withdraw(10.00) }.to change { subject.balance }.by(-10.00)
      expect(subject.balance).to be_a BigDecimal
    end
  end
end
