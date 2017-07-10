require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  before { @test_amount = rand(described_class::MAXIMUM_BALANCE) }

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

  describe '#deduct' do
    before { @initial_amount = rand(10..described_class::MAXIMUM_BALANCE) }

    it 'allows deduction' do
      card = described_class.new(@initial_amount)
      fare = rand(@initial_amount)
      expect(card.deduct(fare)).to eq fare
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
  end

  describe '#touch_out' do
    it 'allows the user to touch out' do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
  end

end
