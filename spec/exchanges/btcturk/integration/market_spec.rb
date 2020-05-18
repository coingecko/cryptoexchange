require 'spec_helper'

RSpec.describe 'Btcturk integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_try_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TRY', market: 'btcturk') }

  it 'fetch pairs' do
    pairs = client.pairs('btcturk')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'btcturk'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'btcturk', base: btc_try_pair.base, target: btc_try_pair.target
    expect(trade_page_url).to eq "https://pro.btcturk.com/pro/al-sat/BTC_TRY"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_try_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'TRY'
    expect(ticker.market).to eq 'btcturk'
    expect(ticker.last).to be > 0.0
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_try_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'TRY'
    expect(order_book.market).to eq 'btcturk'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  # it 'fetch trade' do
  #   trades = client.trades(btc_try_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'BTC'
  #   expect(trade.target).to eq 'TRY'
  #   expect(trade.market).to eq 'btcturk'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
