require 'spec_helper'

RSpec.describe 'FTX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'ftx', inst_id: "BTC-PERP", contract_interval: "perpetual") }
  let(:btc_usd_futures_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'ftx', inst_id: "BTC-1227") }
  let(:btc_usd_move_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'ftx', inst_id: "BTC-MOVE-1015") }

  it 'fetch pairs' do
    pairs = client.pairs('ftx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ftx'
    expect(pair.contract_interval).to eq "perpetual"
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'ftx', base: btc_usd_pair.base, target: btc_usd_pair.target, inst_id: btc_usd_pair.inst_id
    expect(trade_page_url).to eq "https://ftx.com/trade/BTC-PERP"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'ftx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "perpetual"
  end

  it 'fetch order book' do
    order_book = client.order_book(btc_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'ftx'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'ftx'
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be_a Numeric
      expect(2018..Date.today.year).to include(Time.at(contract_stat.next_funding_rate_timestamp).year)
    end

    it 'fetch futures contract details' do
      contract_stat = client.contract_stat(btc_usd_futures_pair)

      expect(2019..Date.today.year).to include(Time.at(contract_stat.expire_timestamp).year)
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'futures'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.next_funding_rate_timestamp).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
    end

    it 'fetch move contract details' do
      contract_stat = client.contract_stat(btc_usd_move_pair)

      expect(2019..Date.today.year).to include(Time.at(contract_stat.expire_timestamp).year)
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'move'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.next_funding_rate_timestamp).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
    end
  end
end
