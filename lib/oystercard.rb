class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "Cannot exceed £#{MAXIMUM_BALANCE}" if amount + balance > MAXIMUM_BALANCE
    credit(amount)
    amount
  end

  def maximum_balance
    MAXIMUM_BALANCE
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    @entry_station = station
    fail "Insufficient balance. Please top up." unless balance >= MINIMUM_FARE
  end

  def touch_out
    fare = MINIMUM_FARE
    deduct(fare)
    @entry_station = nil
    fare
  end

  private

  def credit(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
