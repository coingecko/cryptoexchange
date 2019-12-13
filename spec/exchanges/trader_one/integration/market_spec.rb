require 'spec_helper'

RSpec.describe 'TraderOne integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDC', market: 'trader_one') }
  let(:bch_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'USDC', market: 'trader_one') }

  it 'fetch ticker' do
    ticker = client.ticker(bch_usdc_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'USDC'
    expect(ticker.market).to eq 'trader_one'
    #expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdc_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDC'
    expect(order_book.market).to eq 'trader_one'
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
  
    it 'fetch pairs' do
    pairs = client.pairs('trader_one')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'trader_one'
  end
  
  it 'fetch trade' do
    trades = client.trades(btc_usdc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDC'
    expect(trade.market).to eq 'trader_one'
    expect(trade.trade_id).to be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end

end
