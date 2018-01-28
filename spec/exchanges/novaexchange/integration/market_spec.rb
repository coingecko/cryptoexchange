require 'spec_helper'

RSpec.describe 'Novaexchange integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ppc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PPC', target: 'BTC', market: 'novaexchange') }
  let(:doge_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DOGE', target: 'BTC', market: 'novaexchange') }

  it 'fetch pairs' do
    pairs = client.pairs('novaexchange')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'novaexchange'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ppc_btc_pair)

    expect(ticker.base).to eq 'PPC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'novaexchange'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'base/target order' do
    # There is a bug in the API response - the base/target are swapped. For the
    # time being, we are manually changing the order in the code. The purpose of
    # this test is to fail loudly when people from Nova decide to fix this.
    # The currency pair here is chosen such that the exchange rate is extremely
    # small and will remain < 1 even with market fluctuation.

    ticker = client.ticker(doge_btc_pair)
    expect(ticker.last).to be < 1
  end

  it 'fail to parse ticker' do
    expect { client.ticker(Cryptoexchange::Models::MarketPair.new(base: 'ctic2', target: 'esp2', market: 'novaexchange')) }.to raise_error(Cryptoexchange::ResultParseError)
  end
end
