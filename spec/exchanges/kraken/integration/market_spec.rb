require 'spec_helper'

RSpec.describe 'Kraken integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('kraken')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kraken'
  end

  context 'fetch ticker' do
    before(:all) do
      pair = Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'EUR', market: 'kraken')
      @ticker = client.ticker(pair)
    end
    it { expect(@ticker.base).to eq 'BCH' }
    it { expect(@ticker.target).to eq 'EUR' }
    it { expect(@ticker.market).to eq 'kraken' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
