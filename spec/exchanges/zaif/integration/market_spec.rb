require 'spec_helper'

RSpec.describe 'Zaif integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('zaif')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'zaif'
  end

  it 'fetch ticker' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'JPY', market: 'zaif')
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'JPY'
    expect(ticker.market).to eq 'zaif'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'JPY', market: 'zaif')
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'JPY'
    expect(order_book.market).to eq 'zaif'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'JPY', market: 'zaif')
    trades = client.trades(pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'JPY'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'zaif'
  end
end
