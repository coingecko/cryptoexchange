require 'spec_helper'

RSpec.describe 'Mandala integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'mandala' }
  let(:eth_btc_pair) do
    Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'PAX', market: market)
  end

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty
    expect(pairs).not_to include nil
  end

  it 'fetch ticker' do

    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'PAX'
    expect(ticker.market).to eq market

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end


  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)
    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'PAX'
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_a Numeric
  end
end
