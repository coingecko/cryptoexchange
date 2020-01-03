require 'spec_helper'

RSpec.describe 'TokoCrpyto integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_idr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'IDR', market: 'toko_crypto') }

  it 'fetch pairs' do
    pairs = client.pairs('toko_crypto')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'toko_crypto'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'toko_crypto', base: btc_idr_pair.base, target: btc_idr_pair.target
    expect(trade_page_url).to eq "https://www.tokocrypto.com/id/dashboard/BTCIDR"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_idr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'IDR'
    expect(ticker.market).to eq 'toko_crypto'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_idr_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'IDR'
    expect(order_book.market).to eq 'toko_crypto'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
