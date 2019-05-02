require 'spec_helper'

RSpec.describe 'Trade.io integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'BTC', market: 'tradeio') }

  it 'fetch pairs' do
    pairs = client.pairs('tradeio')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tradeio'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url "tradeio", base: ltc_btc_pair.base, target: ltc_btc_pair.target
    expect(trade_page_url).to eq "https://exchange.trade.io/trade/guest?pair=LTC_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'tradeio'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  # it 'fetch order book' do
  #   order_book = client.order_book(ltc_btc_pair)
  #
  #   expect(order_book.base).to eq 'LTC'
  #   expect(order_book.target).to eq 'BTC'
  #   expect(order_book.market).to eq 'tradeio'
  #   expect(order_book.asks).to_not be_empty
  #   expect(order_book.bids).to_not be_empty
  #   expect(order_book.asks.first.price).to_not be_nil
  #   expect(order_book.bids.first.amount).to_not be_nil
  #   expect(order_book.bids.first.timestamp).to be_nil
  #   expect(order_book.asks.count).to be > 10
  #   expect(order_book.bids.count).to be > 10
  #   expect(order_book.timestamp).to be_a Numeric
  #   expect(order_book.payload).to_not be nil
  # end
  #
  # it 'fetch trade' do
  #   trades = client.trades(ltc_btc_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'LTC'
  #   expect(trade.target).to eq 'BTC'
  #   expect(trade.market).to eq 'tradeio'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
