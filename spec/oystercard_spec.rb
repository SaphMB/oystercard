require 'oystercard'

describe Oystercard do
  before { @default_balance = 5 }
  before { @class_default_balance = described_class::DEFAULT_BALANCE }
  before { @maximum_balance = described_class::MAXIMUM_BALANCE }
  before { @minimum_fare = described_class::MINIMUM_FARE }
  before { @test_amount = rand(@maximum_balance - @default_balance) }
  subject(:oystercard) { described_class.new(@default_balance) }
  let(:station) { double :station }

  describe '#initialize' do
    it 'creates a card with the default balance by default' do
      expect(described_class.new.balance).to eq @class_default_balance
    end
  end

  describe '#balance' do
    it 'allows you to view the maximum balance' do
      expect(oystercard.maximum_balance).to eq @maximum_balance
    end
  end

  describe '#top_up' do
    it 'allows top-ups' do
      expect(oystercard.top_up(@test_amount)).to eq @test_amount
    end

    it 'does not allow you to exceed maximum balance' do
      oystercard.top_up(@test_amount)
      another_amount = @maximum_balance - @test_amount + 1
      error_message = "Cannot exceed £#{@maximum_balance}"
      expect { oystercard.top_up(another_amount) }.to raise_error error_message
    end
  end

  describe '#in_journey?' do
    it 'checks the journey status' do
      expect([true, false]).to include(oystercard.in_journey?)
    end
  end

  describe '#touch_in' do
    it 'allows the user to touch in' do
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'the user cannot touc in if the balance is below the minimum fare' do
      card = described_class.new(0)
      error_message = 'Insufficient balance. Please top up.'
      expect { card.touch_in(station) }.to raise_error error_message
    end

    it 'expected to remember the station after touching in' do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it 'allows the user to touch out' do
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'charge minimum fare on touch out' do
      touch_out = proc { oystercard.touch_out }
      balance = proc { oystercard.balance }
      expect { touch_out.call }.to change { balance.call }.by(-@minimum_fare)
    end

    it 'expected to forget the entry station after touching out' do
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end
end
