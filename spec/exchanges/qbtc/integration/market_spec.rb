require 'spec_helper'

RSpec.describe 'QBTC integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bch_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'bch', target: 'usdt', market: 'qbtc') }

  it 'fetch pairs' do
    pairs = client.pairs('qbtc')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'qbtc'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_usdt_pair)
    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'qbtc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bch_usdt_pair)
    expect(order_book.base).to eq 'BCH'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'qbtc'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(bch_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BCH'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq 'qbtc'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
