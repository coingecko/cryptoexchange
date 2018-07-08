require 'spec_helper'

RSpec.describe 'Upbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:krw_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'krw', target: 'btc', market: 'upbit') }

  it 'fetch pairs' do
    pairs = client.pairs('upbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'upbit'
  end

  it 'does not include non ACTIVE pairs' do
    pairs = client.pairs('upbit')
    expect((pairs.select { |p| p.base == 'TRIG' }).empty?).to be true
  end

  it 'fetch ticker' do
    ticker = client.ticker(krw_btc_pair)

    expect(ticker.base).to eq 'KRW'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'upbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(krw_btc_pair)

    expect(order_book.base).to eq 'KRW'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'upbit'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(krw_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'KRW'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'upbit'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
