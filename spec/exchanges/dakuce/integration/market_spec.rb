require 'spec_helper'

RSpec.describe 'Dakuce integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:daku_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DAKU', target: 'USDT', market: 'dakuce', inst_id: 12) }

  it 'fetch pairs' do
    pairs = client.pairs('dakuce')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'dakuce'
  end

  it 'fetch ticker' do
    ticker = client.ticker(daku_usdt_pair)

    expect(ticker.base).to eq 'DAKU'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'dakuce'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(daku_usdt_pair)

    expect(order_book.base).to eq 'DAKU'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'dakuce'
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
    trades = client.trades(daku_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'DAKU'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq 'dakuce'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
