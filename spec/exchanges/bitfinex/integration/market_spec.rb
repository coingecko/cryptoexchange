require 'spec_helper'

RSpec.describe 'Bitfinex integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_adc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'omg', target: 'eth', market: 'bitfinex') }

  it 'fetch pairs' do
    pairs = client.pairs('bitfinex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitfinex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_adc_pair)

    expect(ticker.base).to eq 'OMG'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'bitfinex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_adc_pair)

    expect(order_book.base).to eq 'OMG'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'bitfinex'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
