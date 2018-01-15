require 'spec_helper'

RSpec.describe 'Ethfinex integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'usd', market: 'ethfinex') }

  it 'fetch pairs' do
    pairs = client.pairs('ethfinex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ethfinex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usd_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'ethfinex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_usd_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'ethfinex'

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
end
