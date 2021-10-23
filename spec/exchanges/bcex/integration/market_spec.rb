require 'spec_helper'

RSpec.describe 'Bcex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_ckusd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CKUSD', market: 'bcex') }

  it 'fetch pairs' do
    pairs = client.pairs('bcex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bcex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bcex', base: btc_ckusd_pair.base, target: btc_ckusd_pair.target
    expect(trade_page_url).to eq "https://www.bcex.ca/trade/btc_ckusd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_ckusd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CKUSD'
    expect(ticker.market).to eq 'bcex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_ckusd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'CKUSD'
    expect(order_book.market).to eq 'bcex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_ckusd_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to be nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'CKUSD'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'bcex'
  end

end
