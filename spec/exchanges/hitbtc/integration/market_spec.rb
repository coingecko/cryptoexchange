require 'spec_helper'

RSpec.describe 'Hitbtc integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('hitbtc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'hitbtc'
  end

  context 'fetch ticker' do
    before(:all) do
      btc_usd_pair = Cryptoexchange::Exchanges::Hitbtc::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'hitbtc')
      @ticker = client.ticker(btc_usd_pair)
    end
    it { expect(@ticker.base).to eq 'BTC' }
    it { expect(@ticker.target).to eq 'USD' }
    it { expect(@ticker.market).to eq 'hitbtc' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
