require 'transaction'

describe Transaction do

  context '#deposit' do
  
    it 'records a deposit as a credit' do 
      subject.deposit(10.00)
      expect(subject.credit).to eq(10.00)
    end

  end
  
  context '#withdrawal' do
  
    it 'records a withdrawal as a debit' do
      subject.withdrawal(10.00)
      expect(subject.debit).to eq(10.00)
    end

  end

  context 'initialization values' do
  
    it 'initializes with the current date' do
      time = Time.now
      allow(Time).to receive(:now).and_return(time)
      new_transaction = Transaction.new
      expect(new_transaction.date).to eq(time)
    end

  end

end
