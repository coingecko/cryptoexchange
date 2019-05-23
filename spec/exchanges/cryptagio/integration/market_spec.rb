require 'spec_helper'

RSpec.describe 'Cryptagio integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:omg_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'OMG', target: 'BTC', market: 'cryptagio') }

  it 'fetch pairs' do
    pairs = client.pairs('cryptagio')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'cryptagio'
  end

  it 'fetch ticker' do
    ticker = client.ticker(omg_btc_pair)

    expect(ticker.base).to eq 'OMG'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'cryptagio'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(omg_btc_pair)

    expect(order_book.base).to eq 'OMG'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'cryptagio'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(omg_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'OMG'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'cryptagio'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
