require 'spec_helper'

RSpec.describe 'Latoken integration specs' do
  client = Cryptoexchange::Client.new
  let(:la_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'la', target: 'eth', market: 'latoken') }

  it 'fetch pairs' do
    pairs = client.pairs('latoken')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'latoken'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'latoken', base: la_eth_pair.base, target: la_eth_pair.target
    expect(trade_page_url).to eq "https://latoken.com/exchange/ETH-LA"
  end

  it 'fetch ticker' do
    ticker = client.ticker(la_eth_pair)

    expect(ticker.base).to eq 'LA'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'latoken'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(la_eth_pair)

    expect(order_book.base).to eq 'LA'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'latoken'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be >= 10
    expect(order_book.bids.count).to be >= 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(la_eth_pair)
    trade = trades.first

    expect(trade.base).to eq 'LA'
    expect(trade.target).to eq 'ETH'
    expect(trade.market).to eq 'latoken'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
