require 'spec_helper'

RSpec.describe 'Artisturba integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:etn_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETN', target: 'ETH', market: 'artisturba') }

  it 'fetch pairs' do
    pairs = client.pairs('artisturba')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'artisturba'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'artisturba', base: etn_eth_pair.base, target: etn_eth_pair.target
    expect(trade_page_url).to eq "https://www.artisturba.com/trade/ETN_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(etn_eth_pair)

    expect(ticker.base).to eq 'ETN'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'artisturba'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(etn_eth_pair)

    expect(order_book.base).to eq 'ETN'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'artisturba'
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
    trades = client.trades(etn_eth_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to be nil
    expect(trade.base).to eq 'ETN'
    expect(trade.target).to eq 'ETH'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'artisturba'
  end

end
