require 'spec_helper'

RSpec.describe 'Bitsdaq integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitsdaq' }
  let(:zec_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'zec', target: 'btc', market: 'bitsdaq') }

  it 'fetch pairs' do
    pairs = client.pairs('bitsdaq')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitsdaq'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: zec_btc_pair.base, target: zec_btc_pair.target
    expect(trade_page_url).to eq "https://bitsdaq.com/exchange/ZEC-BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(zec_btc_pair)

    expect(ticker.base).to eq 'ZEC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitsdaq'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(zec_btc_pair)

    expect(order_book.base).to eq 'ZEC'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'bitsdaq'

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trades' do
    trades = client.trades(zec_btc_pair)
    trade = trades.first

    expect(trade.base).to eq 'ZEC'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bitsdaq'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.type).to eq("buy").or eq("sell")
  end
end
