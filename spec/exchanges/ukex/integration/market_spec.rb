require 'spec_helper'

RSpec.describe 'UKEX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_gbp_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'GBP', market: 'ukex') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url eth_gbp_pair.market, base: eth_gbp_pair.base, target: eth_gbp_pair.target
    expect(trade_page_url).to eq "https://www.ukex.com/trade/index/market/eth_gbp"
  end

  it 'fetch pairs' do
    pairs = client.pairs('ukex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ukex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_gbp_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'GBP'
    expect(ticker.market).to eq 'ukex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_gbp_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'GBP'
    expect(order_book.market).to eq 'ukex'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(eth_gbp_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'ETH'
    expect(trade.target).to eq 'GBP'
    expect(trade.market).to eq 'ukex'
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.payload).to_not be nil
  end
end
