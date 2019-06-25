require 'spec_helper'

RSpec.describe 'Boa integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ebst_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EBST', target: 'BTC', market: 'BOA') }

  it 'fetch pairs' do
    pairs = client.pairs('boa')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'boa'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'boa', base: ebst_btc_pair.base, target: ebst_btc_pair.target
    expect(trade_page_url).to eq "https://www.boaexchange.com/market/EBST_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ebst_btc_pair)

    expect(ticker.base).to eq 'EBST'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'boa'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(ebst_btc_pair)

    expect(order_book.base).to eq 'EBST'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'boa'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.payload).to_not be nil
  end
end
