require 'spec_helper'

RSpec.describe 'Kuna integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_uah_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'UAH', market: 'kuna') }

  it 'fetch pairs' do
    pairs = client.pairs('kuna')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kuna'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_uah_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'UAH'
    expect(ticker.market).to eq 'kuna'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_uah_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'UAH'
    expect(order_book.market).to eq 'kuna'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be nil
    expect(order_book.bids.first.amount).to_not be nil
    expect(order_book.bids.first.timestamp).to_not be nil
    expect(order_book.asks.count).to_not be nil
    expect(order_book.bids.count).to_not be nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_uah_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'UAH'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'kuna'
  end

end
