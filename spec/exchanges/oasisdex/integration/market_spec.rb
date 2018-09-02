require 'spec_helper'

RSpec.describe 'OasisDEX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mkr_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'MKR', target: 'ETH', market: 'oasisdex') }

  it 'fetch pairs' do
    pairs = client.pairs('oasisdex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'oasisdex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(mkr_eth_pair)

    expect(ticker.base).to eq 'MKR'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'oasisdex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
