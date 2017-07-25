require 'spec_helper'

RSpec.describe 'Novaexchange integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('novaexchange')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'novaexchange'
  end

  context 'fetch ticker' do
    before(:all) do
      ppc_btc_pair = Cryptoexchange::Exchanges::Novaexchange::Models::MarketPair.new(base: 'PPC', target: 'BTC', market: 'novaexchange')
      @ticker = client.ticker(ppc_btc_pair)
    end
    it { expect(@ticker.base).to eq 'PPC' }
    it { expect(@ticker.target).to eq 'BTC' }
    it { expect(@ticker.market).to eq 'novaexchange' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.high).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end

  context 'base/target order' do
    # There is a bug in the API response - the base/target are swapped. For the
    # time being, we are manually changing the order in the code. The purpose of
    # this test is to fail loudly when people from Nova decide to fix this.
    # The currency pair here is chosen such that the exchange rate is extremely
    # small and will remain < 1 even with market fluctuation.

    doge_btc_pair = Cryptoexchange::Exchanges::Novaexchange::Models::MarketPair.new(base: 'DOGE', target: 'BTC', market: 'novaexchange')
    ticker = client.ticker(doge_btc_pair)
    it { expect(ticker.last).to be < 1 }
  end
end
