require 'spec_helper'

RSpec.describe 'Coinfield integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_cad_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CAD', market: 'coinfield') }

  it 'fetch pairs' do
    pairs = client.pairs('coinfield')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinfield'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinfield', base: btc_cad_pair.base, target: btc_cad_pair.target
    expect(trade_page_url).to eq "https://trade.coinfield.com/pro/trade/BTC-CAD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_cad_pair)

    expect(ticker.base).to eq btc_cad_pair.base
    expect(ticker.target).to eq btc_cad_pair.target
    expect(ticker.market).to eq btc_cad_pair.market
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_cad_pair)
    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'CAD'
    expect(order_book.market).to eq 'coinfield'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_cad_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'CAD'
    expect(trade.type).to be_nil
    expect(trade.price).to be_a Numeric
    expect(trade.amount).to be_a Numeric
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'coinfield'
  end
end
