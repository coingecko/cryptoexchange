require 'spec_helper'

RSpec.describe 'Tokenjar integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'weth', market: 'tokenjar') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenjar')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenjar'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_weth_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'tokenjar'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
