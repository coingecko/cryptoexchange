require 'spec_helper'

RSpec.describe 'Vebitcoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_try_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TRY', market: 'vebitcoin') }

  it 'fetch pairs' do
    pairs = client.pairs('vebitcoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vebitcoin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'vebitcoin', base: btc_try_pair.base, target: btc_try_pair.target
    expect(trade_page_url).to eq "https://www.vebitcoin.com/market/BTC-TRY"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_try_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'TRY'
    expect(ticker.market).to eq 'vebitcoin'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_try_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'TRY'
    expect(order_book.market).to eq 'vebitcoin'

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
