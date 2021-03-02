class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amount, status="pending")
    @sender = sender
    @receiver = receiver
    @status = status
    @amount = amount
  end

  def valid?
    self.sender.valid?
    self.receiver.valid?
  end

  def execute_transaction
    if valid? && @sender.balance > @amount && @status == "pending"
    self.sender.balance -= self.amount
    self.receiver.deposit(self.amount)
    self.status = "complete"
    else 
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
  if @status == "complete" 
      @receiver.balance -= @amount
      @sender.deposit(@amount) 
      @status = "reversed"
    end
  end
end