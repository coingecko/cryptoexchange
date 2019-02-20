require 'spec_helper'

RSpec.describe 'Altmarkets integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:doge_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DOGE', target: 'BTC', market: 'altmarkets') }

  it 'fetch pairs' do
    pairs = client.pairs('altmarkets')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'altmarkets'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'altmarkets', base: doge_btc_pair.base, target: doge_btc_pair.target
    expect(trade_page_url).to eq "https://altmarkets.io/trading/DOGEBTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(doge_btc_pair)

    expect(ticker.base).to eq 'DOGE'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'altmarkets'
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
    expect(order_book.market).to eq 'altmarkets'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(doge_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'DOGE'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'altmarkets'
    expect(trade.trade_id).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
