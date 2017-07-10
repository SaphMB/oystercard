require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it { is_expected.to respond_to :balance }

  describe '#top_up' do
    it 'allows top-ups' do
      @test_amount = rand(100)
      expect(oystercard.top_up(@test_amount)).to eq @test_amount
    end
  end
end
