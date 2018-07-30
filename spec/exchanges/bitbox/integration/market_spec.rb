require 'spec_helper'

RSpec.describe 'Bitbox integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xrp_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'xrp', target: 'btc', market: 'bitbox') }

  it 'fetch pairs' do
    pairs = client.pairs('bitbox')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitbox'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xrp_btc_pair)

    expect(ticker.base).to eq 'XRP'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitbox'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(xrp_btc_pair)

    expect(order_book.base).to eq 'XRP'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'bitbox'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(xrp_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'XRP'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bitbox'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
