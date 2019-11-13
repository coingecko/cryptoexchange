require 'spec_helper'

RSpec.describe 'CME Futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'cme_futures', contract_interval: "AUG 2019", inst_id: "BTCQ9") }

  it 'fetch pairs' do
    pairs = client.pairs('cme_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.inst_id).to_not be nil
    expect(pair.market).to eq 'cme_futures'
    expect(pair.contract_interval).to eq "AUG 2019"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'cme_futures'
    expect(ticker.inst_id).to eq 'BTCQ9'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be nil
    expect(ticker.bid).to be nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "AUG 2019"
  end

  context 'fetch contract stat' do
    it 'fetch expire_timestamp only' do
      contract_stat = client.contract_stat(btc_usd_pair)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'cme_futures'
      expect(2019..Date.today.year).to include(Time.at(contract_stat.expire_timestamp).year)
      expect(contract_stat.timestamp).to be nil
      expect(contract_stat.index_identifier).to eq 'CmeFutures-BTC'
      expect(contract_stat.index_name).to eq 'CME Bitcoin Reference Rate'

      expect(contract_stat.payload).to_not be nil
    end
  end
end
