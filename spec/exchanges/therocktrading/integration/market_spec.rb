require 'spec_helper'

RSpec.describe 'Therocktrading integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pairs) { client.pairs('therocktrading') }
  let(:pair) { pairs.first }
  let(:noku_eurn_pair) { Cryptoexchange::Models::MarketPair.new(base: 'NOKU', target: 'EURN', market: 'therocktrading') }

  it 'fetch pairs' do
    expect(pairs).not_to be_empty
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'therocktrading'
  end

  it 'use pair from pairs to fetch ticker' do
    ticker = client.ticker(pair)
    expect(ticker).to_not be nil
  end

  it 'fetch ticker' do
    ticker = client.ticker(noku_eurn_pair)

    expect(ticker.base).to eq 'NOKU'
    expect(ticker.target).to eq 'EURN'
    expect(ticker.market).to eq 'therocktrading'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(noku_eurn_pair)

    expect(order_book.base).to eq 'NOKU'
    expect(order_book.target).to eq 'EURN'
    expect(order_book.market).to eq 'therocktrading'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(noku_eurn_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'NOKU'
    expect(trade.target).to eq 'EURN'
    expect(trade.market).to eq 'therocktrading'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
