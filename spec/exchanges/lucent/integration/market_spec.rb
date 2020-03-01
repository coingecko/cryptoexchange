require 'spec_helper'

RSpec.describe 'Lucent integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USD', market: 'lucent') }

  it 'fetch pairs' do
    pairs = client.pairs('lucent')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'lucent'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'lucent', base: eth_usd_pair.base, target: eth_usd_pair.target
    expect(trade_page_url).to eq "https://lucent.exchange/trading/ethusd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usd_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'lucent'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_usd_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'lucent'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.asks.count).to be >= 1
    expect(order_book.bids.count).to be >= 1
    expect(order_book.payload).to_not be nil
  end
end
