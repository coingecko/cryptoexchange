require 'spec_helper'

RSpec.describe 'Livecoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('livecoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'livecoin'
  end

  context 'fetch ticker' do
    before(:all) do
      client = Cryptoexchange::Client.new
      btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'livecoin')
      @ticker = client.ticker(btc_usd_pair)
    end
    it { expect(@ticker.base).to_not be nil }
    it { expect(@ticker.target).to_not be nil }
    it { expect(@ticker.market).to eq 'livecoin' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
