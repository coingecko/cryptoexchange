require 'spec_helper'

RSpec.describe 'Coss integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'coss') }

  it 'fetch pairs' do
    pairs = client.pairs('coss')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coss'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'coss'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be nil
    expect(ticker.ask).to be nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coss', base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://market.coss.io/api/trades/BTC_USD"
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'coss'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(btc_usd_pair)
    trade = trades.first

    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USD'
    expect(trade.market).to eq 'coss'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
