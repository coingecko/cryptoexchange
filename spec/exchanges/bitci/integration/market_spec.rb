require 'spec_helper'

RSpec.describe 'Bitci integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:zrx_chft_pair) { Cryptoexchange::Models::MarketPair.new(base: 'zrx', target: 'chft', market: 'bitci') }

  it 'fetch pairs' do
    pairs = client.pairs('bitci')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'bitci'
  end

  it 'fetch ticker' do
    ticker = client.ticker(zrx_chft_pair)

    expect(ticker.base).to eq 'ZRX'
    expect(ticker.target).to eq 'CHFT'
    expect(ticker.market).to eq 'bitci'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(zrx_chft_pair)

    expect(order_book.base).to eq 'ZRX'
    expect(order_book.target).to eq 'CHFT'
    expect(order_book.market).to eq 'bitci'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'bitci')
    trades = client.trades(pair)
    trade = trades.first
    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'BTC'
    expect(trade.type).to be nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'bitci'
  end
end
