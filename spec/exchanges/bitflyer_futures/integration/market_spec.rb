require 'spec_helper'

RSpec.describe 'BitflyerFutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_jpy_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'jpy', market: 'bitflyer_futures') }

  it 'fetch pairs' do
    pairs = client.pairs('bitflyer_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'JPY'
    expect(pair.market).to eq 'bitflyer_futures'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url btc_jpy_pair.market, base: btc_jpy_pair.base, target: btc_jpy_pair.target
    expect(trade_page_url).to eq "https://lightning.bitflyer.com/trade/btcfx"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_jpy_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'JPY'
    expect(ticker.market).to eq 'bitflyer_futures'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_jpy_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'JPY'
    expect(order_book.market).to eq 'bitflyer_futures'

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

  it 'fetch trades' do
    trades = client.trades(btc_jpy_pair)
    trade = trades.first

    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'JPY'
    expect(trade.market).to eq 'bitflyer_futures'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
