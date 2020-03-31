require 'spec_helper'

RSpec.describe 'BitmaxFutures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitmax_futures' }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: market, inst_id: "BTC-PERP", contract_interval: "perpetual") }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq market
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, inst_id: btc_usdt_pair.inst_id
    expect(trade_page_url).to eq "https://bitmax.io/#/futures/btc-perp"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
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

  it 'fetch trade' do
    trades = client.trades(btc_usdt_pair)
    trade = trades.sample

    expect(trades).to_not be_empty
    expect(trade.base).to eq 'BTC'
    expect(trade.target).to eq 'USDT'
    expect(trade.market).to eq market
    expect(trade.trade_id).to_not be_nil
    expect(['buy', 'sell']).to include trade.type
    expect(trade.price).to_not be_nil
    expect(trade.amount).to_not be_nil
    expect(trade.timestamp).to be_a Numeric
    expect(trade.payload).to_not be nil
  end


  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usdt_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USDT'
      expect(contract_stat.market).to eq market
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
      expect(contract_stat.open_interest).to be_a Numeric
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_usdt_pair)

      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.funding_rate_percentage).to be_a Numeric
      expect(2018..Date.today.year).to include(Time.at(contract_stat.next_funding_rate_timestamp).year)
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
    end
  end
end
