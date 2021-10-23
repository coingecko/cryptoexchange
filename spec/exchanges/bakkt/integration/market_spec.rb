require 'spec_helper'

RSpec.describe 'Bakkt Futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bakkt' }
  let(:btc_usd) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: market, inst_id: '6137542', contract_interval: "Nov19") }

  it 'fetch pairs' do
    pairs = client.pairs(market)
    pair = pairs[0]
    expect(pair.contract_interval).to eq "Nov19"
    expect(pair.inst_id).to eq "6137542"
    expect(pairs).not_to be_empty
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usd.base, target: btc_usd.target, inst_id: btc_usd.inst_id
    expect(trade_page_url).to eq "https://www.theice.com/products/72035464/Bakkt-Bitcoin-USD-Monthly-Futures/specs"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd)

    expect(ticker.base).to eq btc_usd.base
    expect(ticker.target).to eq btc_usd.target
    expect(ticker.market).to eq market

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.contract_interval).to eq "Nov19"

    expect(ticker.payload).to_not be nil
  end

  context 'fetch contract stat' do
    it 'fetch contract stat and contract details' do
      contract_stat = client.contract_stat(btc_usd)

      expect(contract_stat.base).to eq 'BTC'
      expect(contract_stat.target).to eq 'USD'
      expect(contract_stat.market).to eq 'bakkt'

      expect(contract_stat.contract_type).to eq 'futures'
    end
  end
end
