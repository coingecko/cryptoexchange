require 'spec_helper'

RSpec.describe 'Bitmart integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:abt_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ABT', target: 'BTC', market: 'bitmart', inst_id: '45') }

  it 'fetch pairs' do
    pairs = client.pairs('bitmart')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'ABT'
    expect(pair.target).to eq 'BTC'
    expect(pair.market).to eq 'bitmart'
    expect(pair.inst_id).to eq 45
  end

  it 'fetch ticker' do
    ticker = client.ticker(abt_btc_pair)

    expect(ticker.base).to eq 'ABT'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitmart'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(abt_btc_pair)

    expect(order_book.base).to eq 'ABT'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'bitmart'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(abt_btc_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ABT'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bitmart'
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
