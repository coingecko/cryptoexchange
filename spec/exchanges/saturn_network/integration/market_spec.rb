require 'spec_helper'

RSpec.describe 'SaturnNetwork integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_saturn_pair) { Cryptoexchange::Models::MarketPair.new(base: 'SATURN', target: 'ETH', market: 'saturn_network') }

  it 'fetch pairs' do
    pairs = client.pairs('saturn_network')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'saturn_network'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_saturn_pair)

    expect(ticker.base).to eq 'SATURN'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'saturn_network'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
