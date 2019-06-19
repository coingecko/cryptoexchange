require 'spec_helper'

RSpec.describe 'StakeCube integration specs' do
  let(:market) { 'stake_cube' }
  let(:client) { Cryptoexchange::Client.new }
  let(:doge_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DOGE', target: 'BTC', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: doge_btc_pair.base, target: doge_btc_pair.target
    expect(trade_page_url).to eq "https://stakecube.net/exchange/#{doge_btc_pair.target}-#{doge_btc_pair.base}"
  end

  it 'fetch ticker' do
    ticker = client.ticker(doge_btc_pair)

    expect(ticker.base).to eq doge_btc_pair.base
    expect(ticker.target).to eq doge_btc_pair.target
    expect(ticker.market).to eq doge_btc_pair.market
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(doge_btc_pair)

    expect(order_book.base).to eq doge_btc_pair.base
    expect(order_book.target).to eq doge_btc_pair.target
    expect(order_book.market).to eq doge_btc_pair.market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be nil
    expect(order_book.bids.first.amount).to_not be nil
    expect(order_book.bids.first.timestamp).to be nil
    expect(order_book.asks.count).to_not be nil
    expect(order_book.bids.count).to_not be nil
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(doge_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq doge_btc_pair.base
    expect(trade.target).to eq doge_btc_pair.target
    expect(trade.price).to_not be nil
    expect(trade.amount).to_not be nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq doge_btc_pair.market
  end
end
