require 'spec_helper'

RSpec.describe 'BTCMarkets integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_aud_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'AUD', market: 'btcmarkets') }

  it 'fetch pairs' do
    pairs = client.pairs('btcmarkets')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'btcmarkets'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_aud_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'AUD'
    expect(ticker.market).to eq 'btcmarkets'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_aud_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'AUD'
    expect(order_book.market).to eq 'btcmarkets'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 1
    expect(order_book.bids.count).to be > 11
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end
  #
  # it 'fetch trade' do
  #   trades = client.trades(btc_aud_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'BTC'
  #   expect(trade.target).to eq 'AUD'
  #   expect(trade.market).to eq 'btcmarkets'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
