require 'spec_helper'

RSpec.describe 'DachExchange integration specs' do
  let(:market) { 'dach_exchange' }
  let(:client) { Cryptoexchange::Client.new }
  let(:btt_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTT', target: 'BTC', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq market
  end


  it 'fetch ticker' do
    ticker = client.ticker(btt_btc_pair)

    expect(ticker.base).to eq btt_btc_pair.base
    expect(ticker.target).to eq btt_btc_pair.target
    expect(ticker.market).to eq btt_btc_pair.market
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
