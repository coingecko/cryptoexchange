require 'spec_helper'

RSpec.describe 'Hopex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', inst_id: 'BTCUSDT', contract_interval: 'perpetual', market: 'hopex') }

  it 'fetch pairs' do
    pairs = client.pairs('hopex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.contract_interval).to eq 'perpetual'
    expect(pair.inst_id).to eq 'BTCUSDT'
    expect(pair.market).to eq 'hopex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'hopex', base: btc_usdt_pair.base, target: btc_usdt_pair.target, inst_id: btc_usdt_pair.inst_id
    expect(trade_page_url).to eq "https://web.hopex.com/trade?marketCode=BTCUSDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'hopex'
    expect(ticker.inst_id).to eq 'BTCUSDT'
    expect(ticker.contract_interval).to eq 'perpetual'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat' do
      contract_stat = client.contract_stat(btc_usdt_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USDT'
      expect(contract_stat.market).to eq 'hopex'
      expect(contract_stat.index).to be_a Numeric
      expect(contract_stat.index_identifier).to be nil
      expect(contract_stat.index_name).to be nil
      expect(contract_stat.open_interest).to be nil
      expect(contract_stat.timestamp).to be nil

      expect(contract_stat.payload).to_not be nil
    end

    it 'fetch perpetual contract details' do
      contract_stat = client.contract_stat(btc_usdt_pair)

      expect(contract_stat.expire_timestamp).to be nil
      expect(contract_stat.start_timestamp).to be nil
      expect(contract_stat.contract_type).to eq 'perpetual'
      expect(contract_stat.funding_rate_percentage).to be nil
      expect(contract_stat.funding_rate_percentage_predicted).to be nil
    end
  end
end
