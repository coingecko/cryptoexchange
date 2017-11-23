require 'spec_helper'

RSpec.describe 'Gate integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('gate')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gate'
  end

  it 'fetch ticker' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'USDT', target: 'BTC', market: 'gate')
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'USDT'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'gate'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'USDT', target: 'BTC', market: 'gate')
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'USDT'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'gate'

    expect(order_book.asks).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.asks.first.amount).to_not be_nil
    expect(order_book.asks.first.timestamp).to_not be_nil

    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil

    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'USDT', target: 'BTC', market: 'gate')
    trades = client.trades(pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'USDT'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'gate'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
