require 'spec_helper'

RSpec.describe 'Okcoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'okcoin' }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'okcoin') }

  it 'fetch pairs' do
    pairs = client.pairs('okcoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'okcoin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://www.okcoin.com/market#product=btc_usd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'okcoin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
