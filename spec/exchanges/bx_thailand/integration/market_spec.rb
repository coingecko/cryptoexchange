require 'spec_helper'

RSpec.describe 'BxThailand integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_thb_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'THB', market: 'bx_thailand') }

  it 'fetch pairs' do
    pairs = client.pairs('bx_thailand')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bx_thailand'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_thb_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'THB'
    expect(ticker.market).to eq 'bx_thailand'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_nil
    expect(ticker.low).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'THB'
    expect(order_book.market).to eq 'bx_thailand'

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
