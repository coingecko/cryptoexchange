require 'spec_helper'

RSpec.describe 'HbTop Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:gsc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'GSC', target: 'BTC', market: 'hb_top') }

  it 'fetch pairs' do
    pairs = client.pairs('hb_top')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hb_top'
  end

  it 'fetch ticker' do
    ticker = client.ticker(gsc_btc_pair)

    expect(ticker.base).to eq 'GSC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'hb_top'
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(gsc_btc_pair)

    expect(order_book.base).to eq 'GSC'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'hb_top'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
