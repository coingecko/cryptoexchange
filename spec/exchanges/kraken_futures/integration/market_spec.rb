require 'spec_helper'

RSpec.describe 'kraken_futures integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'kraken_futures' }
  let(:eth_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USD', market: 'kraken_futures', contract_interval: "quarter") }

  it 'fetch pairs' do
    pairs = client.pairs('kraken_futures')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kraken_futures'
    expect(pair.contract_interval).to eq "quarter"
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eth_usd_pair.base, target: eth_usd_pair.target
    expect(trade_page_url).to eq "https://futures.kraken.com/dashboard"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usd_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'kraken_futures'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
    expect(ticker.contract_interval).to eq "quarter"
  end
end
