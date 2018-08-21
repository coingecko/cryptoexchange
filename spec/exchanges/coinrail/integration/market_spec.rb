require 'spec_helper'

RSpec.describe 'Coinrail integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'KRW', market: 'coinrail') }

  it 'fetch pairs' do
    pairs = client.pairs('coinrail')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinrail'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinrail', base: btc_krw_pair.base, target: btc_krw_pair.target
    expect(trade_page_url).to eq "https://coinrail.co.kr/api/public/system/market/info?fiat_currency=KRW&lang=ko"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_krw_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'coinrail'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_krw_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'KRW'
    expect(order_book.market).to eq 'coinrail'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_krw_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'KRW'
    expect(trade.market).to eq 'coinrail'
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
