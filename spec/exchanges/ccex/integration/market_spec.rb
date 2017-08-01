require 'spec_helper'

RSpec.describe 'Ccex integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('ccex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'ccex'
  end

  context 'fetch ticker' do
    before(:all) do
      usd_btc_pair = Cryptoexchange::Models::MarketPair.new(base: 'USD', target: 'BTC', market: 'ccex')
      @ticker = client.ticker(usd_btc_pair)
    end
    it { expect(@ticker.base).to eq 'USD' }
    it { expect(@ticker.target).to eq 'BTC' }
    it { expect(@ticker.market).to eq 'ccex' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
