require 'spec_helper'

RSpec.describe 'Coinut integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_sgd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'SGD', market: 'coinut', inst_id: "852380") }

  it 'fetch pairs' do
    pending "response: Must include auth file named cryptoexchange_api_keys.yml in config/cryptoexchange"
    pairs = client.pairs('coinut')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinut'
  end

  it 'fetch ticker' do
    pending "response: Must include auth file named cryptoexchange_api_keys.yml in config/cryptoexchange"
    ticker = client.ticker(btc_sgd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'SGD'
    expect(ticker.market).to eq 'coinut'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be nil
    expect(ticker.ask).to be nil
    expect(ticker.change).to be nil
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    pending "response: Must include auth file named cryptoexchange_api_keys.yml in config/cryptoexchange"
    order_book = client.order_book(btc_sgd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'SGD'
    expect(order_book.market).to eq 'coinut'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    pending "response: Must include auth file named cryptoexchange_api_keys.yml in config/cryptoexchange"
    trades = client.trades(btc_sgd_pair)

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'SGD'
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
    expect(trade.market).to eq 'coinut'
  end
end
