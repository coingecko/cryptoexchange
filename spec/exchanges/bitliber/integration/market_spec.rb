require 'spec_helper'

RSpec.describe 'Bitliber integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:aeon_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'AEON', target: 'BTC', market: 'bitliber') }

  it 'fetch pairs' do
    pairs = client.pairs('bitliber')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitliber'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitliber', base: aeon_btc_pair.base, target: aeon_btc_pair.target
    expect(trade_page_url).to eq "https://bitliber.com/markets/aeon-btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(aeon_btc_pair)
    expect(ticker.base).to eq 'AEON'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitliber'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(aeon_btc_pair)

    expect(order_book.base).to eq 'AEON'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'bitliber'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(aeon_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'AEON'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bitliber'
    expect(trade.trade_id).to be_nil
    expect(trade.type).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end

end
