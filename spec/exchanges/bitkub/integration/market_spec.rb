require 'spec_helper'

RSpec.describe 'Bitkub integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_thb_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'THB', market: 'bitkub') }

  it 'fetch pairs' do
    pairs = client.pairs('bitkub')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitkub'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitkub', base: btc_thb_pair.base, target: btc_thb_pair.target
    expect(trade_page_url).to eq "https://www.bitkub.com/market/BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_thb_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'THB'
    expect(ticker.market).to eq 'bitkub'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_thb_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'THB'
    expect(order_book.market).to eq 'bitkub'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be nil
    expect(order_book.bids.first.amount).to_not be nil
    expect(order_book.bids.first.timestamp).to_not be nil
    expect(order_book.asks.count).to_not be nil
    expect(order_book.bids.count).to_not be nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end


  pending 'fetch trade' do
    trades = client.trades(btc_thb_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'THB'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'bitkub'
  end
end
