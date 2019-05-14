require 'spec_helper'

RSpec.describe 'Omgfin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'omgfin' }
  let(:bat_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'bat', target: 'eth', market: 'omgfin') }

  it 'fetch pairs' do
    pairs = client.pairs('omgfin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'omgfin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: bat_btc_pair.base, target: bat_btc_pair.target
    expect(trade_page_url).to eq "https://omgfin.com/exchange/trade/market/BATETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bat_btc_pair)

    expect(ticker.base).to eq 'BAT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'omgfin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bat_btc_pair)

    expect(order_book.base).to eq 'BAT'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end
end
