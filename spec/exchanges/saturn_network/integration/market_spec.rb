require 'spec_helper'

RSpec.describe 'SaturnNetwork integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_saturn_pair) { Cryptoexchange::Models::MarketPair.new(base: 'SATURN', target: 'ETH', inst_id: "0xb9440022a095343b440d590fcd2d7a3794bd76c8", market: 'saturn_network') }

  it 'fetch pairs' do
    pairs = client.pairs('saturn_network')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'saturn_network'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'saturn_network', base: eth_saturn_pair.base, target: eth_saturn_pair.target, inst_id: eth_saturn_pair.inst_id
    expect(trade_page_url).to eq "https://www.saturn.network/exchange/ETH/order-book/0xb9440022a095343b440d590fcd2d7a3794bd76c8"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_saturn_pair)

    expect(ticker.base).to eq 'SATURN'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'saturn_network'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_saturn_pair)

    expect(order_book.base).to eq 'SATURN'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'saturn_network'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_a Numeric
    expect(order_book.asks.count).to be > 2
    expect(order_book.bids.count).to be > 2
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  xit 'fetch trade' do
    trades = client.trades(eth_saturn_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.trade_id).to_not be_nil
    expect(trade.base).to eq 'SATURN'
    expect(trade.target).to eq 'ETH'
    expect(trade.market).to eq 'saturn_network'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
