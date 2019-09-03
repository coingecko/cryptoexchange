require 'spec_helper'

RSpec.describe 'Yobit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:px_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PX', target: 'BTC', market: 'yobit') }

  it 'fetch pairs' do
    pairs = client.pairs('yobit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'yobit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'yobit', base: px_btc_pair.base, target: px_btc_pair.target
    expect(trade_page_url).to eq "https://yobit.net/en/trade/PX/BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(px_btc_pair)

    expect(ticker.base).to eq 'PX'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'yobit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(px_btc_pair)

    expect(order_book.base).to eq 'PX'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'yobit'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.asks.count).to be >= 1
    expect(order_book.bids.count).to be >= 1
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end
end
