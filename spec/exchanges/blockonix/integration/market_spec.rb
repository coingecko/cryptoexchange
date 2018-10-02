require 'spec_helper'

RSpec.describe 'Blockonix integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_bdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BDT', target: 'ETH', inst_id: 'baseAddress=0x0000000000000000000000000000000000000000&quoteAddress=0x741f58cd68d24f361cc0ee0d3aaf7df2bf16132e', market: 'blockonix') }

  it 'fetch pairs' do
    pairs = client.pairs('blockonix')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'blockonix'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_bdt_pair)

    expect(ticker.base).to eq 'BDT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'blockonix'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_bdt_pair)

    expect(order_book.base).to eq 'BDT'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'blockonix'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
  
  it 'fetch trade' do
    trades = client.trades(eth_bdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BDT'
    expect(trade.target).to eq 'ETH'
    expect(trade.market).to eq 'blockonix'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
