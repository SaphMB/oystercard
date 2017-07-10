class Oystercard
  MAXIMUM_BALANCE = 90
  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Cannot exceed £#{MAXIMUM_BALANCE}" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
    amount
  end

  def deduct(fare)
    @balance -= fare
    fare
  end

  def maximum_balance
    MAXIMUM_BALANCE
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
