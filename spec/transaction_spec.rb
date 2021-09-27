require 'transaction'

describe Transaction do

  it 'records a deposit as a credit' do 
    subject.deposit(10)
    expect(subject.credit).to eq(10)
  end

  it 'records a withdrawal as a debit' do
    subject.withdrawal(10)
    expect(subject.debit).to eq(10)
  end
end