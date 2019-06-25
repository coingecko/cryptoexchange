require 'spec_helper'

RSpec.describe 'Indodax Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_idr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'IDR', market: 'indodax') }

  it 'fetch pairs' do
    pairs = client.pairs('indodax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'indodax'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_idr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'IDR'
    expect(ticker.market).to eq 'indodax'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_idr_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'IDR'
    expect(order_book.market).to eq 'indodax'
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

  it 'fetch trade' do
    trades = client.trades(btc_idr_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'IDR'
    expect(trade.market).to eq 'indodax'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
