require 'spec_helper'

RSpec.describe 'QBTC integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btr_cnyt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTR', target: 'CNYT', market: 'qbtc') }

  it 'fetch pairs' do
    pairs = client.pairs('qbtc')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'qbtc'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'qbtc', base: btr_cnyt_pair.base, target: btr_cnyt_pair.target
    expect(trade_page_url).to eq "https://www.myqbtc.com/markets?symbol=BTR_CNYT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btr_cnyt_pair)
    expect(ticker.base).to eq 'BTR'
    expect(ticker.target).to eq 'CNYT'
    expect(ticker.market).to eq 'qbtc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btr_cnyt_pair)
    expect(order_book.base).to eq 'BTR'
    expect(order_book.target).to eq 'CNYT'
    expect(order_book.market).to eq 'qbtc'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btr_cnyt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTR'
    expect(trade.target).to eq 'CNYT'
    expect(trade.market).to eq 'qbtc'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
