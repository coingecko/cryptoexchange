require 'spec_helper'

RSpec.describe 'Dydx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_dai_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'DAI', market: 'dydx') }

  it 'fetch pairs' do
    pairs = client.pairs('dydx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'dydx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_dai_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'DAI'
    expect(ticker.market).to eq 'dydx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_dai_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'DAI'
    expect(order_book.market).to eq 'dydx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.payload).to_not be nil
  end
end
