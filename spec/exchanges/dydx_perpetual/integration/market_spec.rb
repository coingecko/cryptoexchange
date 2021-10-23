require 'spec_helper'

RSpec.describe 'DydxPerpetual integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'dydx_perpetual' }
  let(:btc_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDC', market: market, inst_id: "PBTC-USDC", contract_interval: "perpetual") }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
    expect(pair.inst_id).to eq btc_usdc_pair.inst_id
    expect(pair.contract_interval).to eq btc_usdc_pair.contract_interval
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url(market,
      base: btc_usdc_pair.base,
      target: btc_usdc_pair.target,
      inst_id: btc_usdc_pair.inst_id,
    )

    expect(trade_page_url).to eq "https://trade.dydx.exchange/perpetual/PBTC-USDC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDC'
    expect(ticker.market).to eq market
    expect(ticker.contract_interval).to eq btc_usdc_pair.contract_interval
    expect(ticker.inst_id).to eq btc_usdc_pair.inst_id
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usdc_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USDC'
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

  it 'fetch contract stat' do
    contract_stat = client.contract_stat(btc_usdc_pair)

    expect(contract_stat.base).to eq 'BTC'
    expect(contract_stat.target).to eq 'USDC'
    expect(contract_stat.market).to eq market
    expect(contract_stat.index).to eq 9170.7
    expect(contract_stat.index_identifier).to be nil
    expect(contract_stat.index_name).to be nil
    expect(contract_stat.timestamp).to be nil
    expect(contract_stat.expire_timestamp).to be nil
    expect(contract_stat.start_timestamp).to be nil

    expect(contract_stat.contract_type).to eq 'perpetual'
    expect(contract_stat.open_interest).to eq 5559747102.0
    expect(contract_stat.funding_rate_percentage).not_to be nil
  end
end
