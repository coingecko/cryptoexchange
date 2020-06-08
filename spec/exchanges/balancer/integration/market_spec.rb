require 'spec_helper'

RSpec.describe 'Balancer integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'DAI', market: 'balancer') }

  it 'fetch pairs' do
    pairs = client.pairs('balancer')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'balancer'
  end

  it 'fetch ticker' do
    allow(Time).to receive(:now).and_return(Time.utc(2020, 2, 4))

    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'DAI'
    expect(ticker.market).to eq 'balancer'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
