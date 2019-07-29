require 'spec_helper'

RSpec.describe 'FTXSpot integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ftt_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'FTT', target: 'USD', market: 'ftx_spot') }

  it 'fetch pairs' do
    pairs = client.pairs('ftx_spot')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ftx_spot'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ftt_usd_pair)

    expect(ticker.base).to eq 'FTT'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'ftx_spot'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(ftt_usd_pair)

    expect(order_book.base).to eq 'FTT'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'ftx_spot'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.payload).to_not be nil
  end
end
