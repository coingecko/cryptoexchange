require 'spec_helper'

RSpec.describe 'BhexFutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_swap_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'bhex_futures', contract_interval: "perpetual", inst_id: "BTC-SWAP-USDT") }

  it 'fetch pairs' do
    pairs = client.pairs('bhex_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bhex_futures'
    expect(pair.contract_interval).to_not be nil
    expect(pair.inst_id).to_not be nil
  end

  it 'fetch futures ticker' do
    ticker = client.ticker(btc_swap_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'bhex_futures'
    expect(ticker.inst_id).to eq 'BTC-SWAP-USDT'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "perpetual"
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_swap_usdt_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq 'bhex_futures'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_a Numeric
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_swap_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq 'bhex_futures'
    expect(trade.trade_id).to be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end  

  it 'fetch contract stat' do
    contract_stat = client.contract_stat(btc_swap_usdt_pair)

    expect(contract_stat.base).to eq 'BTC'
    expect(contract_stat.target).to eq 'USDT'
    expect(contract_stat.market).to eq 'bhex_futures'
    expect(contract_stat.index).to be_a Numeric
    expect(contract_stat.funding_rate_percentage).to be_a Numeric
    expect(contract_stat.timestamp).to be nil
    expect(contract_stat.payload).to_not be nil
  end
end
