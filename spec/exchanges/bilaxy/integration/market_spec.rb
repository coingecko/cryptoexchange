require 'spec_helper'

RSpec.describe 'Bilaxy integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bilaxy' }
  let(:eos_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EOS', target: 'ETH', market: 'bilaxy') }

  it 'fetch pairs' do
    pairs = client.pairs('bilaxy')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bilaxy'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eos_eth_pair.base, target: eos_eth_pair.target
    expect(trade_page_url).to eq "https://bilaxy.com/trade/EOS_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_eth_pair)

    expect(ticker.base).to eq 'EOS'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'bilaxy'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eos_eth_pair)

    expect(order_book.base).to eq 'EOS'
    expect(order_book.target).to eq 'ETH'
    expect(order_book.market).to eq 'bilaxy'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(eos_eth_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'EOS'
    expect(trade.target).to eq 'ETH'
    expect(trade.market).to eq 'bilaxy'
    expect(trade.trade_id).to be_a Numeric
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end
end
