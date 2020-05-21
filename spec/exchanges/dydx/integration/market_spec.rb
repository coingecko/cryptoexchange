require 'spec_helper'

RSpec.describe 'Dydx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_dai_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'DAI', market: 'dydx') }
  let(:pbtc_usdc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PBTC', target: 'USDC', market: 'dydx') }

  it 'fetch pairs' do
    pairs = client.pairs('dydx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'dydx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_dai_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'DAI'
    expect(ticker.market).to eq 'dydx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(eth_dai_pair)

    expect(order_book.base).to eq 'ETH'
    expect(order_book.target).to eq 'DAI'
    expect(order_book.market).to eq 'dydx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.payload).to_not be nil
  end

  it 'fetch contract stat perpetual' do
    contract_stat = client.contract_stat(pbtc_usdc_pair)

    expect(contract_stat.base).to eq 'PBTC'
    expect(contract_stat.target).to eq 'USDC'
    expect(contract_stat.market).to eq 'dydx'
    expect(contract_stat.index).to be nil
    expect(contract_stat.index_identifier).to be nil
    expect(contract_stat.index_name).to be nil
    expect(contract_stat.timestamp).to be nil
    expect(contract_stat.expire_timestamp).to be nil
    expect(contract_stat.start_timestamp).to be nil

    expect(contract_stat.contract_type).to eq 'perpetual'
    expect(contract_stat.open_interest).to eq 5180925000
    expect(contract_stat.funding_rate_percentage).not_to be nil
  end
end
