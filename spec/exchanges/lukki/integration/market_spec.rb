require 'spec_helper'

RSpec.describe 'Lukki integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:npxs_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'NPXS', target: 'BTC', market: 'lukki') }

  it 'fetch pairs' do
    pairs = client.pairs('lukki')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'lukki'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'lukki', base: npxs_btc_pair.base, target: npxs_btc_pair.target
    expect(trade_page_url).to eq "https://app.lukki.io/?pair=NPXS_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(npxs_btc_pair)

    expect(ticker.base).to eq 'NPXS'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'lukki'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(npxs_btc_pair)

  #   expect(order_book.base).to eq 'NPXS'
  #   expect(order_book.target).to eq 'BTC'
  #   expect(order_book.market).to eq 'lukki'

  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to be_nil
  #   expect(order_book.asks.count).to be > 1
  #   expect(order_book.bids.count).to be > 1
  #   expect(order_book.timestamp).to be_nil
  #   expect(order_book.payload).to_not be nil
  # end
end
