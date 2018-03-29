require 'spec_helper'

RSpec.describe 'Coinone integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'KRW', market: 'coinone') }

  it 'fetch pairs' do
    pairs = client.pairs('coinone')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinone'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_krw_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'coinone'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order_book' do
    order_book = client.order_book(eth_krw_pair)

    expect(order_book.base).to eq eth_krw_pair.base
    expect(order_book.target).to eq eth_krw_pair.target
    expect(order_book.market).to eq eth_krw_pair.market
    expect(order_book.asks).to_not be nil
    expect(order_book.bids).to_not be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(eth_krw_pair)
    first_trade_result = trades.first

    expect(first_trade_result.base).to eq eth_krw_pair.base
    expect(first_trade_result.target).to eq eth_krw_pair.target
    expect(first_trade_result.market).to eq eth_krw_pair.market
    expect(first_trade_result.price).to_not be nil
    expect(first_trade_result.amount).to_not be nil
    expect(first_trade_result.timestamp).to be_a Numeric
    expect(first_trade_result.payload).to_not be nil
  end
end
