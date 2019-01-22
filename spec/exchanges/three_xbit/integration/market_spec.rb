require 'spec_helper'

RSpec.describe 'ThreeXbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:doge_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DOGE', target: 'BTC', market: 'three_xbit') }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'three_xbit')  }

  it 'fetch pairs' do
    pairs = client.pairs('three_xbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'three_xbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'three_xbit', base: doge_btc_pair.base, target: doge_btc_pair.target
    expect(trade_page_url).to eq 'https://app.3xbit.com.br/orderbook/BTC/DOGE'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'three_xbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(doge_btc_pair)

    expect(order_book.base).to eq 'DOGE'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'three_xbit'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to be_a Numeric
    expect(order_book.bids.first.amount).to be_a Numeric
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 1
    expect(order_book.bids.count).to be > 1
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(doge_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'DOGE'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'three_xbit'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to be_a Numeric
    expect(trade.amount).to be_a Numeric
    expect(trade.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.payload).to_not be nil
  end
end
