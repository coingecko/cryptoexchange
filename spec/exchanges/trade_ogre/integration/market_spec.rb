require 'spec_helper'

RSpec.describe 'TradeOgre integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:aeon_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'AEON', target: 'BTC', market: 'trade_ogre') }

  it 'fetch pairs' do
    pairs = client.pairs('trade_ogre')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'trade_ogre'
  end

  it 'fetch ticker' do
    ticker = client.ticker(aeon_btc_pair)

    expect(ticker.base).to eq 'AEON'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'trade_ogre'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(aeon_btc_pair)

    expect(order_book.base).to eq 'AEON'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'trade_ogre'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be nil
    expect(order_book.bids.first.amount).to_not be nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.asks.count).to_not be nil
    expect(order_book.bids.count).to_not be nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(aeon_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'AEON'
    expect(trade.target).to eq 'BTC'
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'trade_ogre'
  end

end
