require 'spec_helper'

RSpec.describe 'Palitanx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_ltc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'LTC', market: 'palitanx') }

  it 'fetch pairs' do
    pairs = client.pairs('palitanx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'palitanx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_ltc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'palitanx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_ltc_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'LTC'
    expect(order_book.market).to eq 'palitanx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_ltc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'LTC'
    expect(trade.market).to eq 'palitanx'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
