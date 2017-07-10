class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Cannot exceed £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    increase_balance(amount)
    amount
  end



  def maximum_balance
    MAXIMUM_BALANCE
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Insufficient balance. Please top up." unless balance >= MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  private

  def increase_balance(amount)
    @balance += amount
  end

  def decrease_balance(amount)
    @balance -= amount
  end

  def deduct(fare)
    decrease_balance(fare)
    fare
  end
end
