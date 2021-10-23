require 'spec_helper'

RSpec.describe 'Xfutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', inst_id: "BTC-USDT", market: 'xfutures') }
  let(:xocean_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XOCEAN', target: 'BTC', inst_id: "XOCEAN-BTC", market: 'xfutures') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url btc_usdt_pair.market, base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq "https://www.xfutures.io/spot/trade#product=btc_usdt"
  end

  it 'fetch pairs' do
    pairs = client.pairs('xfutures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'xfutures'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'xfutures'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdt_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'xfutures'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(order_book.timestamp).year)
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(xocean_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'XOCEAN'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'xfutures'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.payload).to_not be nil
  end
end
