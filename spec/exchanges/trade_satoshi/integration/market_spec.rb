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

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'trade_satoshi', base: base, target: target
    expect(trade_page_url).to eq "https://tradesatoshi.com/Exchange?market=LTC_BTC"
  end

  # {
  #   "market":"LTC_BTC",
  #   "high":0.01749999,
  #   "low":0.01520006,
  #   "volume":469.05469918,
  #   "baseVolume":7.71450537,
  #   "last":0.01680000,
  #   "bid":0.01680000,
  #   "ask":0.01699999,
  #   "openBuyOrders":59,
  #   "openSellOrders":70,
  #   "change":0.0
  # }
  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq market
    expect(ticker.last).to eq 0.01680000
    expect(ticker.high).to eq 0.01749999
    expect(ticker.low).to eq 0.01520006
    expect(ticker.volume).to eq 469.05469918
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
