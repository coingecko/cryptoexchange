require 'spec_helper'

RSpec.describe 'Everbloom integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:oed_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: '0ED', target: 'ETH', inst_id: 'e0x0000000000000000000000000000000000000000_e0x8e10f6bb9c973d61321c25a2b8d865825f4aa57b', market: 'everbloom') }

  it 'fetch pairs' do
    pairs = client.pairs('everbloom')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'everbloom'
  end

  it 'fetch ticker' do
    ticker = client.ticker(oed_eth_pair)

    expect(ticker.base).to eq '0ED'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'everbloom'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(oed_eth_pair)
  #
  #   expect(order_book.base).to eq '0ED'
  #   expect(order_book.target).to eq 'ETH'
  #   expect(order_book.market).to eq 'everbloom'
  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to be_nil
  #   expect(order_book.asks.count).to be > 10
  #   expect(order_book.bids.count).to be > 10
  #   expect(order_book.timestamp).to be_a Numeric
  #   expect(order_book.payload).to_not be nil
  # end

  # it 'fetch trade' do
  #   trades = client.trades(oed_eth_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq '0ED'
  #   expect(trade.target).to eq 'ETH'
  #   expect(trade.market).to eq 'everbloom'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
