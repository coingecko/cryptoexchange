require 'spec_helper'

RSpec.describe 'Catex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'catex') }

  it 'fetch pairs' do
    pairs = client.pairs('catex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'catex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'catex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_eth_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'catex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
