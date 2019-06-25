require 'spec_helper'

RSpec.describe 'Zg integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:zg_cnz_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ZG', target: 'CNZ', market: 'zg') }

  it 'fetch pairs' do
    pairs = client.pairs('zg')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'zg'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'zg', base: zg_cnz_pair.base, target: zg_cnz_pair.target
    expect(trade_page_url).to eq "https://www.zg.com/exchange?coin=ZG_CNZ&tab=all"
  end

  it 'fetch ticker' do
    ticker = client.ticker(zg_cnz_pair)

    expect(ticker.base).to eq 'ZG'
    expect(ticker.target).to eq 'CNZ'
    expect(ticker.market).to eq 'zg'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(zg_cnz_pair)

    expect(order_book.base).to eq 'ZG'
    expect(order_book.target).to eq 'CNZ'
    expect(order_book.market).to eq 'zg'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 1
    expect(order_book.bids.count).to be > 1
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(zg_cnz_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ZG'
    expect(trade.target).to eq 'CNZ'
    expect(trade.market).to eq 'zg'
    expect(trade.trade_id).to be nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to be_a Numeric
    expect(trade.amount).to be_a Numeric
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
