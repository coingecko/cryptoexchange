require 'spec_helper'

RSpec.describe 'Swiftex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mynt_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'MYNT', target: 'BTC', market: 'swiftex') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url mynt_btc_pair.market, base: mynt_btc_pair.base, target: mynt_btc_pair.target
    expect(trade_page_url).to eq "https://swiftex.co/markets/mynt-btc"
  end

  it 'fetch pairs' do
    pairs = client.pairs('swiftex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'swiftex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(mynt_btc_pair)

    expect(ticker.base).to eq 'MYNT'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'swiftex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(mynt_btc_pair)

    expect(order_book.base).to eq 'MYNT'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'swiftex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 1
    expect(order_book.bids.count).to be > 1
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  # it 'fetch trade' do
  #   trades = client.trades(mynt_btc_pair)
  #   trade = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'MYNT'
  #   expect(trade.target).to eq 'BTC'
  #   expect(trade.market).to eq 'swiftex'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
  #   expect(trade.payload).to_not be nil
  # end
end
