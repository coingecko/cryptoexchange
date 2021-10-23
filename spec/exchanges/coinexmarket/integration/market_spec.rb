require 'spec_helper'

RSpec.describe 'Coinexmarket integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_ltc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'ltc', market: 'coinexmarket') }

  it 'fetch pairs' do
    pairs = client.pairs('coinexmarket')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinexmarket'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_ltc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'coinexmarket'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_ltc_pair)
    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'LTC'
    expect(order_book.market).to eq 'coinexmarket'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first).to_not be_nil
    expect(order_book.bids.first).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
