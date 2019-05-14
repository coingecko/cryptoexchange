require 'spec_helper'

RSpec.describe 'SixX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdx_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDX', market: 'six_x') }

  it 'fetch pairs' do
    pairs = client.pairs('six_x')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'six_x'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'six_x', base: btc_usdx_pair.base, target: btc_usdx_pair.target
    expect(trade_page_url).to eq "https://www.6x.com/market?symbol=BTC%2FUSDX&board=0"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdx_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDX'
    expect(ticker.market).to eq 'six_x'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdx_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDX'
    expect(order_book.market).to eq 'six_x'

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
