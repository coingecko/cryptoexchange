require 'byebug'
require 'spec_helper'

RSpec.describe 'Namebase integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'namebase' }
  let(:hns_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'HNS', target: 'BTC', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: hns_btc_pair.base, target: hns_btc_pair.target
    expect(trade_page_url).to eq "https://www.namebase.io/pro"
  end

  it 'fetch ticker' do
    ticker = client.ticker(hns_btc_pair)

    expect(ticker.base).to eq hns_btc_pair.base
    expect(ticker.target).to eq hns_btc_pair.target
    expect(ticker.market).to eq market

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.contract_interval).to eq ""

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(hns_btc_pair)
  
    expect(order_book.base).to eq hns_btc_pair.base
    expect(order_book.target).to eq hns_btc_pair.target
    expect(order_book.market).to eq market
  
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

  # Pending: Trades spec
end
