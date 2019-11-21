require 'spec_helper'

RSpec.describe 'Bybit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', inst_id: 'BTCUSD', contract_interval: 'perpetual', market: 'bybit') }

  it 'fetch pairs' do
    pairs = client.pairs('bybit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to eq 'perpetual'
    expect(pair.inst_id).to eq 'BTCUSD'
    expect(pair.market).to eq 'bybit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bybit', base: btc_usd_pair.base, target: btc_usd_pair.target, inst_id: btc_usd_pair.inst_id
    expect(trade_page_url).to eq "https://www.bybit.com/app/exchange/BTCUSD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'bybit'
    expect(ticker.inst_id).to eq 'BTCUSD'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'bybit'
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
  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'bybit'
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.funding_rate_percentage).to be_a Numeric
      expect(2018..Date.today.year).to include(Time.at(contract_stat.next_funding_rate_timestamp).year)
      expect(contract_stat.funding_rate_percentage_predicted).to be_a Numeric
    end
  end
end
