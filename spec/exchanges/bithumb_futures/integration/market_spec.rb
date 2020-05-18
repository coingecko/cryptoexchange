require 'spec_helper'

RSpec.describe 'BithumbFutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bithumb_futures' }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: market, contract_interval: "perpetual", inst_id: "BTC-PERP") }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.market).to eq market
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, inst_id: btc_usdt_pair.inst_id
    expect(trade_page_url).to eq "https://bithumbfutures.com/#/futures/btc-perp"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.inst_id).to eq 'BTC-PERP'    
    expect(ticker.market).to eq market
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdt_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDT'
    expect(order_book.market).to eq market
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 0
    expect(order_book.bids.count).to be > 0
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  it 'fetch trade' do
    trades = client.trades(btc_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq market
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be nil
    expect(trade.payload).to_not be nil
  end

  it 'fetch contract stat' do
    contract_stat = client.contract_stat(btc_usdt_pair)

    expect(contract_stat.base).to eq 'BTC'
    expect(contract_stat.target).to eq 'USDT'
    expect(contract_stat.market).to eq market
    expect(contract_stat.index).to be_a Numeric
    expect(contract_stat.open_interest).to be_a Numeric
    expect(contract_stat.funding_rate_percentage).to be_a Numeric
    expect(contract_stat.next_funding_rate_timestamp).to be_a Numeric
    expect(contract_stat.timestamp).to be nil
    expect(contract_stat.payload).to_not be nil
  end
end
