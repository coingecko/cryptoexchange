require 'spec_helper'

RSpec.describe 'Trade Satoshi integration specs' do
  let(:base)   { "ltc" }
  let(:target) { "btc" }
  let(:market) { 'trade_satoshi' }
  let(:client) { Cryptoexchange::Client.new }
  let(:pair)   { Cryptoexchange::Models::MarketPair.new(base: base, target: target, market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq "PAK"
    expect(pair.target).to eq "BTC"
    expect(pair.market).to eq 'trade_satoshi'
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
