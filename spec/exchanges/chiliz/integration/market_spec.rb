require 'spec_helper'

RSpec.describe 'Chiliz integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btp1_chz_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTP1', target: 'CHZ', market: 'chiliz') }

  it 'fetch pairs' do
    pairs = client.pairs('chiliz')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'chiliz'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btp1_chz_pair)
    expect(ticker.base).to eq 'BTP1'
    expect(ticker.target).to eq 'CHZ'
    expect(ticker.market).to eq 'chiliz'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btp1_chz_pair)

    expect(order_book.base).to eq 'BTP1'
    expect(order_book.target).to eq 'CHZ'
    expect(order_book.market).to eq 'chiliz'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
