require 'spec_helper'

RSpec.describe 'Ddex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:abt_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ABT', target: 'WETH', market: 'ddex') }

  it 'fetch pairs' do
    pairs = client.pairs('ddex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ddex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'ddex', base: abt_weth_pair.base, target: abt_weth_pair.target
    expect(trade_page_url).to eq "https://ddex.io/trade/ABT-WETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(abt_weth_pair)

    expect(ticker.base).to eq 'ABT'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'ddex'

    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric

    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(abt_weth_pair)

    expect(order_book.base).to eq 'ABT'
    expect(order_book.target).to eq 'WETH'
    expect(order_book.market).to eq 'ddex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(abt_weth_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ABT'
    expect(trade.target).to eq 'WETH'
    expect(trade.market).to eq 'ddex'
    expect(trade.trade_id).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
