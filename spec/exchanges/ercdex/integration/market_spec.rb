require 'spec_helper'

RSpec.describe 'ERCDex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:weth_dai_pair) { Cryptoexchange::Models::MarketPair.new(base: 'weth', target: 'dai', market: 'ercdex') }

  it 'fetch pairs' do
    pairs = client.pairs('ercdex')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ercdex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(weth_dai_pair)
    expect(ticker.base).to eq 'WETH'
    expect(ticker.target).to eq 'DAI'
    expect(ticker.market).to eq 'ercdex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(weth_dai_pair)
    expect(order_book.base).to eq 'WETH'
    expect(order_book.target).to eq 'DAI'
    expect(order_book.market).to eq 'ercdex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
end
