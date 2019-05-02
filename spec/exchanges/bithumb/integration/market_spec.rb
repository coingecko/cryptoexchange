require 'spec_helper'

RSpec.describe 'Bithumb integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'krw', market: 'bithumb') }

  it 'fetch pairs' do
    pairs = client.pairs('bithumb')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bithumb'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url btc_krw_pair.market, base: btc_krw_pair.base, target: btc_krw_pair.target
    expect(trade_page_url).to eq "https://www.bithumb.com/trade/order/BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_krw_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'bithumb'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_krw_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'KRW'
    expect(order_book.market).to eq 'bithumb'

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
