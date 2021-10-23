require 'spec_helper'

RSpec.describe 'Huobi Dm integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'huobi_dm' }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', inst_id: "BTC_CW", contract_interval: 'weekly', market: 'huobi_dm') }
  let(:perp_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USD', inst_id: "ETH-USD", contract_interval: 'perpetual', market: 'huobi_dm') }

  it 'fetch pairs' do
    pairs = client.pairs('huobi_dm')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'huobi_dm'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://dm.huobi.com/en-us"
  end

  it 'fetch perpetual ticker' do
    ticker = client.ticker(perp_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'huobi_dm'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.volume.to_i).to eq (ticker.payload["amount"].to_f / 2.0).to_i
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'huobi_dm'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.volume.to_i).to eq (ticker.payload["amount"].to_f / 2.0).to_i
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  it 'fetch order book' do
    order_book = client.order_book(pair)

    expect(order_book.base).to eq 'BTC'
    expect(order_book.target).to eq 'USD'
    expect(order_book.market).to eq 'huobi_dm'

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

  it 'fetch trades' do
    trades = client.trades(pair)
    trade = trades.first

    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USD'
    expect(trade.market).to eq 'huobi_dm'

    expect(trade.amount).to_not be_nil
    expect(trade.price).to_not be_nil
    expect(2000..Date.today.year).to include(Time.at(trade.timestamp).year)
    expect(trade.trade_id).to_not be_nil
    expect(trade.type).to eq("buy").or eq("sell")
  end

  context 'fetch contract stat' do
    it 'fetch perpetual contract stat' do
      contract_stat = client.contract_stat(perp_pair)

      expect(contract_stat.base).to eq 'ETH'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'huobi_dm'
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.funding_rate_percentage).to be_a Numeric
      expect(2018..Date.today.year).to include(Time.at(contract_stat.next_funding_rate_timestamp).year)
      expect(contract_stat.funding_rate_percentage_predicted).to be_a Numeric

      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to eq "HuobiDm-ETH-USD"
      expect(contract_stat.index_name).to eq "Huobi DM ETH-USD"
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch contract stat' do
      contract_stat = client.contract_stat(pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'huobi_dm'
      expect(2019..Date.today.year).to include(Time.at(contract_stat.expire_timestamp).year)
      expect(2019..Date.today.year).to include(Time.at(contract_stat.start_timestamp).year)
      expect(contract_stat.contract_type).to eq 'futures'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.next_funding_rate_timestamp).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to eq "HuobiDm-BTC"
      expect(contract_stat.index_name).to eq "Huobi DM BTC"
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end
  end
end
