require 'spec_helper'

RSpec.describe 'Ethex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:req_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'REQ', target: 'ETH', market: 'ethex') }

  it 'fetch pairs' do
    pairs = client.pairs('ethex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'ethex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(req_eth_pair)

    expect(ticker.base).to eq 'REQ'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'ethex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
