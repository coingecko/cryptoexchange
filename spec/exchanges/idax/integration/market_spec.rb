require 'spec_helper'

RSpec.describe 'Idax integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'idax') }

  it 'fetch pairs' do
    pairs = client.pairs('idax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'idax'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'idax', base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://www.idax.mn/#/exchange?pairname=ETH_BTC"
  end

  it 'fetch order book' do
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'idax'

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

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'idax'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
