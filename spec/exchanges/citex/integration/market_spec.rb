require 'spec_helper'

RSpec.describe 'Citex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'citex' }
  let(:veil_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'VEIL', target: 'BTC', market: 'citex') }

  it 'fetch pairs' do
    pairs = client.pairs('citex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'citex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(veil_btc_pair)

    expect(ticker.base).to eq 'VEIL'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'citex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
