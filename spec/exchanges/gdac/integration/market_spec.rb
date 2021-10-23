require 'spec_helper'

RSpec.describe 'Gdac integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'krw', market: 'gdac') }

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'gdac', base: eth_krw_pair.base, target: eth_krw_pair.target
    expect(trade_page_url).to eq "https://www.gdac.com/exchange/ETH/KRW"
  end

  it 'fetch pairs' do
    pairs = client.pairs('gdac')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gdac'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_krw_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'gdac'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_krw_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'KRW'
    expect(order_book.market).to eq 'gdac'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be >= 1
    expect(order_book.bids.count).to be >= 1
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
