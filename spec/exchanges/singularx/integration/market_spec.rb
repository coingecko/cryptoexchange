require 'spec_helper'

RSpec.describe 'Singularx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xes_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XES', target: 'ETH', market: 'singularx') }

  it 'fetch pairs' do
    pairs = client.pairs('singularx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'singularx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xes_eth_pair)

    expect(ticker.base).to eq 'XES'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'singularx'

    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
