require 'spec_helper'

RSpec.describe 'Mercatox integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'mercatox') }

  it 'fetch pairs' do
    pairs = client.pairs('mercatox')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'mercatox'
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('mercatox')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'ETH'
    expect(pair.target).to eq 'BTC'
    expect(pair.market).to eq 'mercatox'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'mercatox'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
