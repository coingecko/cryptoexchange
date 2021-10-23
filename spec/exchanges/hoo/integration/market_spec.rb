require 'spec_helper'

RSpec.describe 'Hoo integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'hoo' }
  let(:bhc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'USDT', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: bhc_usdt_pair.base, target: bhc_usdt_pair.target
    expect(trade_page_url).to eq "https://hoo.com/trade/bch-usdt"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bhc_usdt_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be nil
    expect(ticker.bid).to be nil
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bhc_usdt_pair)

    expect(order_book.base).to eq 'BCH'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
