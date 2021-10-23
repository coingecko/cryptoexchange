require 'spec_helper'

RSpec.describe 'CompoundFinance integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'compound_finance' }
  let(:ceth_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ceth', target: 'eth', market: 'compound_finance') }

  it 'fetch pairs' do
    pairs = client.pairs('compound_finance')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'compound_finance'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: ceth_eth_pair.base, target: ceth_eth_pair.target
    expect(trade_page_url).to eq "https://app.compound.finance"
  end

  it 'fetch ticker' do
    allow(Time).to receive(:now).and_return(Time.utc(2020, 2, 4))
    ticker = client.ticker(ceth_eth_pair)

    expect(ticker.base).to eq 'CETH'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'compound_finance'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
