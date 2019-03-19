require 'spec_helper'

RSpec.describe 'Bankera integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'bankera') }

  it 'fetch pairs' do
    pairs = client.pairs('bankera')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bankera'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bankera', base: eth_btc_pair.base, target: eth_btc_pair.target
    expect(trade_page_url).to eq "https://exchange.bankera.com/market/ETH-BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bankera'
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
    order_book = client.order_book(eth_btc_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'BTC'
    expect(order_book.market).to eq 'bankera'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(eth_btc_pair)
    trade  = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'BTC'
    expect(trade.market).to eq 'bankera'
    expect(trade.trade_id).to be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to be_a Numeric
    expect(trade.amount).to be_a Numeric
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
