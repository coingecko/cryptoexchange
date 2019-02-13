require 'spec_helper'

RSpec.describe 'Catex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'ETH', market: 'catex') }

  it 'fetch pairs' do
    pairs = client.pairs('catex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'catex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'catex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
