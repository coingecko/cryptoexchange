require 'spec_helper'

RSpec.describe 'Bitsoda integration specs' do
  let(:market) { "bitsoda" }
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usdt', market: 'bitsoda') }

  it 'fetch pairs' do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdt_pair)

    expect(order_book.base).to eq btc_usdt_pair.base
    expect(order_book.target).to eq btc_usdt_pair.target
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
