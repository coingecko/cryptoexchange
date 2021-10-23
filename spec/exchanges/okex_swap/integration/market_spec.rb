require 'spec_helper'

RSpec.describe 'OkexSwap integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xbt_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'okex_swap', contract_interval: "perpetual", inst_id: "BTC-USD-SWAP") }
  let(:xbt_usd_pair_weekly) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'okex_swap', contract_interval: "weekly", inst_id: "BTC-USD-191115") }

  it 'fetch pairs' do
    pairs = client.pairs('okex_swap')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'okex_swap'
    expect(pair.contract_interval).to eq "perpetual"
    expect(pair.inst_id).to eq "BTC-USD-SWAP"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xbt_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'okex_swap'
    expect(ticker.inst_id).to eq 'BTC-USD-SWAP'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "perpetual"
  end

  it 'fetch futures ticker' do
    ticker = client.ticker(xbt_usd_pair_weekly)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'okex_swap'
    expect(ticker.inst_id).to eq 'BTC-USD-191115'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "weekly"
  end

  it 'fetch order book' do
    order_book = client.order_book(xbt_usd_pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'okex_swap'
    expect(order_book.asks).to_not be_empty
    expect(order_book.bids).to_not be_empty
    expect(order_book.asks.first.price).to_not be_nil
    expect(order_book.bids.first.amount).to_not be_nil
    expect(order_book.bids.first.timestamp).to be_nil
    expect(order_book.asks.count).to be > 10
    expect(order_book.bids.count).to be > 10
    expect(order_book.timestamp).to be nil
    expect(order_book.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(xbt_usd_pair_weekly)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'okex_swap'
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_name).to eq "Okex BTC"
      expect(contract_stat.index_identifier).to eq "OkexSwap-BTC"
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil
      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(xbt_usd_pair)
      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.funding_rate_percentage).to be_a Numeric
      expect(2018..Date.today.year).to include(Time.at(contract_stat.next_funding_rate_timestamp).year)
      expect(contract_stat.funding_rate_percentage_predicted).to be_a Numeric
    end

    it 'fetch futures contract details' do
      contract_stat = client.contract_stat(xbt_usd_pair_weekly)

      expect(2019..Date.today.year).to include(Time.at(contract_stat.expire_timestamp).year)
      expect(2019..Date.today.year).to include(Time.at(contract_stat.start_timestamp).year)
      expect(contract_stat.contract_type).to eq 'futures'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.next_funding_rate_timestamp).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
    end
  end

  # it 'fetch trade' do
  #   trades = client.trades(xbt_usd_pair)
  #   trade = trades.sample

  #   expect(trades).to_not be_empty
  #   expect(trade.base).to eq 'XBT'
  #   expect(trade.target).to eq 'USD'
  #   expect(trade.market).to eq 'bitmex'
  #   expect(trade.trade_id).to_not be_nil
  #   expect(['buy', 'sell']).to include trade.type
  #   expect(trade.price).to_not be_nil
  #   expect(trade.amount).to_not be_nil
  #   expect(trade.timestamp).to be_a Numeric
  #   expect(trade.payload).to_not be nil
  # end
end
