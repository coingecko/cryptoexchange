require 'spec_helper'

RSpec.describe 'Delta Futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'delta_futures' }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: market, inst_id: 'BTCUSD', contract_interval: "perpetual") }
  let(:btc_usd_pair_futures) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: market, inst_id: 'BTCUSD_27Dec', contract_interval: "") }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    pair = pairs[0]
    expect(pair.contract_interval).to eq "perpetual"
    expect(pair.inst_id).to eq "BTCUSD"
    expect(pairs).not_to be_empty
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usd_pair.base, target: btc_usd_pair.target, inst_id: btc_usd_pair.inst_id
    expect(trade_page_url).to eq "https://www.delta.exchange/app/trade/BTC/BTCUSD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq btc_usd_pair.base
    expect(ticker.target).to eq btc_usd_pair.target
    expect(ticker.market).to eq market

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.contract_interval).to eq "perpetual"

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq btc_usd_pair.base
    expect(order_book.target).to eq btc_usd_pair.target
    expect(order_book.market).to eq market

    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be_nil
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'delta_futures'
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to eq "DeltaFutures-BTC"
      expect(contract_stat.index_name).to eq "Delta Exchange BTC"
      expect(contract_stat.funding_rate_percentage).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual details' do
      contract_stat = client.contract_stat(btc_usd_pair)
      expect(contract_stat.contract_type).to eq 'perpetual'
    end

    it 'fetch futures details' do
      contract_stat = client.contract_stat(btc_usd_pair_futures)
      expect(contract_stat.contract_type).to eq 'futures'
    end
  end
end
