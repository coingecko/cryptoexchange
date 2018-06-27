require 'spec_helper'

RSpec.describe 'Omnitrade integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_brl_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'BRL', market: 'omnitrade') }

  it 'fetch pairs' do
    pairs = client.pairs('omnitrade')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'omnitrade'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_brl_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'BRL'
    expect(ticker.market).to eq 'omnitrade'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_brl_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'BRL'
    expect(order_book.market).to eq 'omnitrade'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_brl_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'BRL'
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'omnitrade'
  end
end
