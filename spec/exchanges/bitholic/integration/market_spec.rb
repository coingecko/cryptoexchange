require 'spec_helper'

RSpec.describe 'Bitholic integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:qtum_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'QTUM', market: 'bitholic') }

  it 'fetch pairs' do
    pairs = client.pairs('bitholic')
    expect(pairs).not_to be_empty

    pair = pairs.sample

    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitholic'
  end

  it 'fetch ticker' do
    ticker = client.ticker(qtum_btc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'QTUM'
    expect(ticker.market).to eq 'bitholic'
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(qtum_btc_pair)
    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'QTUM'
    expect(order_book.market).to eq 'bitholic'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(qtum_btc_pair)
    trade = trades.first
    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'QTUM'
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'bitholic'
  end
end
