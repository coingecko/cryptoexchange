require 'spec_helper'

RSpec.describe 'Remitano integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'remitano' }
  let(:btc_myr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'MYR', market: 'remitano') }

  it 'fetch pairs' do
    pairs = client.pairs('remitano')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'remitano'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_myr_pair.base, target: btc_myr_pair.target
    expect(trade_page_url).to eq "https://remitano.com"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_myr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'MYR'
    expect(ticker.market).to eq 'remitano'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_myr_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'MYR'
    expect(order_book.market).to eq 'remitano'

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
