require 'spec_helper'

RSpec.describe 'Coinplace integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:cpl_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'CPL', target: 'BTC', market: 'coinplace') }

  it 'fetch pairs' do
    pairs = client.pairs('coinplace')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinplace'
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('coinplace')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'LRC'
    expect(pair.target).to eq 'BTC'
    expect(pair.market).to eq 'coinplace'
  end

  it 'fetch ticker' do
    ticker = client.ticker(cpl_btc_pair)

    expect(ticker.base).to eq 'CPL'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'coinplace'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
