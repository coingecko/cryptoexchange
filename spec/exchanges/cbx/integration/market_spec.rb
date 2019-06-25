require 'spec_helper'

RSpec.describe 'Cbx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xin_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XIN', target: 'BTC', market: 'cbx') }

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'cbx', base: xin_btc_pair.base, target: xin_btc_pair.target
    expect(trade_page_url).to eq "https://www.cbx.one/trade/XIN-BTC"
  end

  it 'fetch pairs' do
    pairs = client.pairs('cbx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'cbx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xin_btc_pair)
    expect(ticker.base).to eq 'XIN'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'cbx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'XIN', target: 'BTC', market: 'cbx')
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'XIN'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'cbx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'XIN', target: 'BTC', market: 'cbx')
    trades = client.trades(pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'XIN'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'cbx'
    expect(trade.trade_id).to_not be_nil
    expect(['ASK', 'BID']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end

end
