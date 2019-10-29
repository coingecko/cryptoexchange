require 'spec_helper'

RSpec.describe 'Prime XBT integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'prime_xbt', inst_id: 'BTC/USD') }

  it 'has trade_page_url' do
    trade_page_url = client.trade_page_url btc_usd_pair.market, base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://web.primexbt.com/"
  end

  it 'fetch pairs' do
    pairs = client.pairs('prime_xbt')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'prime_xbt'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'prime_xbt'
    expect(ticker.inst_id).to eq 'BTC/USD'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'prime_xbt'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 5
    expect(order_book.bids.count).to be > 5
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'prime_xbt'
      expect(contract_stat.contract_type).to eq 'perpetual'
    end
  end
end
