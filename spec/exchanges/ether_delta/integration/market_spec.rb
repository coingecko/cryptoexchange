require 'spec_helper'

RSpec.describe 'EtherDelta integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('ether_delta')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'ether_delta'
  end

  it 'fetch ticker' do
    eth_ppt_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'PPT', market: 'ether_delta')
    ticker = client.ticker(eth_ppt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'PPT'
    expect(ticker.market).to eq 'ether_delta'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
