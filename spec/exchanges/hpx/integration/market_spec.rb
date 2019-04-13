require 'spec_helper'

RSpec.describe 'HPX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:hc_cnyt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'HC', target: 'CNYT', market: 'hpx') }

  it 'fetch pairs' do
    pairs = client.pairs('hpx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hpx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(hc_cnyt_pair)

    expect(ticker.base).to eq 'HC'
    expect(ticker.target).to eq 'CNYT'
    expect(ticker.market).to eq 'hpx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(hc_cnyt_pair)

    expect(order_book.base).to eq 'HC'
    expect(order_book.target).to eq 'CNYT'
    expect(order_book.market).to eq 'hpx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 1
    expect(order_book.bids.count).to be > 1
    expect(order_book.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(order_book.timestamp).year)
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(hc_cnyt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'HC'
    expect(trade.target).to eq 'CNYT'
    expect(trade.market).to eq 'hpx'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_nil
    expect(trade.payload).to_not be nil
  end
end
