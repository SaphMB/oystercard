class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Cannot exceed £#{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
    amount
  end

  def maximum_balance
    MAXIMUM_BALANCE
  end

end
