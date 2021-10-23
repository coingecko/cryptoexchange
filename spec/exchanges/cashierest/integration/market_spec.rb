require 'spec_helper'

RSpec.describe 'Cashierest integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'KRW', market: 'cashierest') }

  ENV["ENV"] = "test"

  it 'fetch pairs' do
    pairs = client.pairs('cashierest')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'cashierest'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_krw_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'cashierest'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_krw_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'KRW'
    expect(order_book.market).to eq 'cashierest'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
