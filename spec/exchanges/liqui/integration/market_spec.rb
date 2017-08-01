require 'spec_helper'

RSpec.describe 'Liqui integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('liqui')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'liqui'
  end

  context 'fetch ticker' do
    before(:all) do
      ltc_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'BTC', market: 'liqui')
      @ticker = client.ticker(ltc_btc_pair)
    end
    it { expect(@ticker.base).to eq 'LTC' }
    it { expect(@ticker.target).to eq 'BTC' }
    it { expect(@ticker.market).to eq 'liqui' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
