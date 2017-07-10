require 'oystercard'

describe Oystercard do
  before { @default_balance = 5}
  subject(:oystercard) { described_class.new(@default_balance) }
  before { @test_amount = rand(described_class::MAXIMUM_BALANCE - @default_balance) }

  describe '#initialize' do
    it 'creates a card with the default balance by default' do
      expect(described_class.new.balance).to eq described_class::DEFAULT_BALANCE
    end
  end

  describe '#balance' do
    it 'allows you to view the maximum balance' do
      expect(oystercard.maximum_balance).to eq described_class::MAXIMUM_BALANCE
    end
  end

  describe '#top_up' do

    it 'allows top-ups' do
      expect(oystercard.top_up(@test_amount)).to eq @test_amount
    end

    it 'does not allow you to exceed maximum balance' do
      oystercard.top_up(@test_amount)
      expect { oystercard.top_up(described_class::MAXIMUM_BALANCE - @test_amount + 1) }.to raise_error "Cannot exceed £#{described_class::MAXIMUM_BALANCE}"
    end
  end

  describe '#in_journey?' do
    it 'checks the journey status' do
    expect([true,false]).to include(oystercard.in_journey?)
    end
  end

  describe '#touch_in' do

    it 'allows the user to touch in' do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it 'the user cannot touc in if the balance is below the minimum fare' do
      card = described_class.new(0)
      expect { card.touch_in }.to raise_error "Insufficient balance. Please top up."
    end
  end

  describe '#touch_out' do
    it 'allows the user to touch out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'charge minimum fare on touch out' do
      expect { oystercard.touch_out}.to change {oystercard.balance}.by(-described_class::MINIMUM_FARE)
    end

  end
end
