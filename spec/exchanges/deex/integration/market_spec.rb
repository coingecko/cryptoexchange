require 'spec_helper'

RSpec.describe 'DEEX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:deex_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DEEX', target: 'BTC', market: 'deex') }

  it 'fetch pairs' do
    pairs = client.pairs('deex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'deex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(deex_btc_pair)

    expect(ticker.base).to eq 'DEEX'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'deex'

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(deex_btc_pair)
  #
  #   expect(order_book.base).to eq 'DEEX'
  #   expect(order_book.target).to eq 'BTC'
  #   expect(order_book.market).to eq 'deex'
  #
  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to_not be_nil
  #   expect(order_book.asks.count).to be > 10
  #   expect(order_book.bids.count).to be > 10
  #   expect(order_book.timestamp).to be_a Numeric
  #   expect(order_book.payload).to_not be nil
  # end
end
