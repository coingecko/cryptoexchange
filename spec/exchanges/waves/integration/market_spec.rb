require 'spec_helper'

RSpec.describe 'Waves integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ett_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETT', target: 'BTC', market: 'waves') }

  it 'fetch pairs' do
    pairs = client.pairs('waves')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'waves'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ett_btc_pair)

    expect(ticker.base).to eq 'ETT'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'waves'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(ett_btc_pair)

    expect(order_book.base).to eq 'ETT'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'waves'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end  

  # it 'fetch trade' do
  #   trades = client.trades(ett_btc_pair)
  #   trade  = trades.sample
  #
  #   expect(trades).to_not be_empty
  #   expect(trade.trade_id).to_not be_nil
  #   expect(trade.base).to eq 'ETT'
  #   expect(trade.target).to eq 'BTC'
  #   expect(trade.trade_id).to_not be nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be nil
  #   expect(trade.amount).to_not be nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  #   expect(trade.market).to eq 'waves'
  # end

end
