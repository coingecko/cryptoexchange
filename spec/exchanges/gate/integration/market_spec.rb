require 'spec_helper'

RSpec.describe 'Gate integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bch_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'USDT', market: 'gate') }

  it 'fetch pairs' do
    pairs = client.pairs('gate')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gate'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'gate', base: bch_usdt_pair.base, target: bch_usdt_pair.target
    expect(trade_page_url).to eq "https://gate.io/trade/BCH_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_usdt_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'gate'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(bch_usdt_pair)

    expect(order_book.base).to eq 'BCH'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'gate'

    expect(order_book.asks).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.asks.first.amount).to_not be_nil
    expect(order_book.asks.first.timestamp).to_not be_nil

    expect(order_book.bids).to_not be_empty
    expect(order_book.bids.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil

    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(bch_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BCH'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq 'gate'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
