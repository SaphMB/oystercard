require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it { is_expected.to respond_to :balance }

  describe '#top_up' do

    before { @test_amount = rand(described_class::MAXIMUM_BALANCE) }

    it 'allows top-ups' do
      expect(oystercard.top_up(@test_amount)).to eq @test_amount
    end

    it 'allows you to view the maximum balance' do
      expect(oystercard.maximum_balance).to eq described_class::MAXIMUM_BALANCE
    end

    it 'does not allow you to exceed maximum balance' do
      oystercard.top_up(@test_amount)
      expect { oystercard.top_up(described_class::MAXIMUM_BALANCE - @test_amount + 1) }.to raise_error "Cannot exceed £#{described_class::MAXIMUM_BALANCE}"
    end
  end


end
