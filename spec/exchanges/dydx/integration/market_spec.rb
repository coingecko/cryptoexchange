require 'spec_helper'

RSpec.describe 'Dydx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_dai_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'DAI', market: 'dydx') }

  it 'fetch pairs' do
    pairs = client.pairs('dydx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'dydx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_dai_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'DAI'
    expect(ticker.market).to eq 'dydx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
