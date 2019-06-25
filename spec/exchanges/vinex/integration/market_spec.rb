require 'spec_helper'

RSpec.describe 'Vinex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'vinex') }

  it 'fetch pairs' do
    pairs = client.pairs('vinex')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vinex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'vinex', base: "ETH", target: "BTC"
    expect(trade_page_url).to eq "https://vinex.network/market/BTC_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'vinex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'vinex'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be >= 3
    expect(order_book.bids.count).to be >= 3
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
