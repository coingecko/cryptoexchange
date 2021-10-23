require 'spec_helper'

RSpec.describe 'Cashpayz integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:cpc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'CPC', target: 'BTC', market: 'cashpayz') }

  it 'fetch pairs' do
    pairs = client.pairs('cashpayz')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'cashpayz'
  end

  it 'fetch ticker' do
    ticker = client.ticker(cpc_btc_pair)
    expect(ticker.base).to eq 'CPC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'cashpayz'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(cpc_btc_pair)

    expect(order_book.base).to eq 'CPC'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'cashpayz'
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
    trades = client.trades(cpc_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'CPC'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'cashpayz'
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end

end
