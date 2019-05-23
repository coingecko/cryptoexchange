require 'spec_helper'

RSpec.describe 'Graviex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:gio_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'GIO', target: 'BTC', market: 'graviex') }

  it 'fetch pairs' do
    pairs = client.pairs('graviex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'graviex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(gio_btc_pair)

    expect(ticker.base).to eq 'GIO'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'graviex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(gio_btc_pair)

    expect(order_book.base).to eq 'GIO'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'graviex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end  
end
