require 'spec_helper'

RSpec.describe 'Bcoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bcoin' }
  let(:base) { 'BCH' }
  let(:target) { 'BTC' }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: base, target: target, market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq base
    expect(ticker.target).to eq target
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
