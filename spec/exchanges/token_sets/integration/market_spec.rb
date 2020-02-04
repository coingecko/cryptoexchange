require 'spec_helper'

RSpec.describe 'TokenSets integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETHMOONX', target: 'USD', market: 'token_sets', inst_id: 'ethmoonx') }

  it 'fetch pairs' do
    pairs = client.pairs('token_sets')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'token_sets'
  end

  it 'fetch ticker' do
    allow(Time).to receive(:now).and_return(Time.utc(2020, 2, 4))

    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'ETHMOONX'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'token_sets'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
