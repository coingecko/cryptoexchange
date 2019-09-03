require 'spec_helper'

RSpec.describe 'Bitbay integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'bitbay') }

  it 'fetch pairs' do
    pairs = client.pairs('bitbay')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BCC'
    expect(pair.target).to eq 'USD'
    expect(pair.market).to eq 'bitbay'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url btc_usd_pair.market
    expect(trade_page_url).to eq "https://bitbay.net/en/exchange-rate"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'bitbay'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'bitbay'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end
end
