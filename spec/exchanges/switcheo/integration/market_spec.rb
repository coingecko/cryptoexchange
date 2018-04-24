require 'spec_helper'

RSpec.describe 'Switcheo integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:swh_neo_pair) { Cryptoexchange::Models::MarketPair.new(base: 'SWH', target: 'NEO', market: 'switcheo') }

  it 'fetch pairs' do
    pairs = client.pairs('switcheo')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'switcheo'
  end

  it 'fetch ticker' do
    ticker = client.ticker(swh_neo_pair)

    expect(ticker.base).to_not be 'SWH'
    expect(ticker.target).to_not be 'NEO'
    expect(ticker.market).to eq 'switcheo'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
