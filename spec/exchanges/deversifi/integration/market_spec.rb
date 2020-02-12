require 'spec_helper'

RSpec.describe 'deversifi integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'usd', market: 'deversifi') }

  it 'fetch pairs' do
    pairs = client.pairs('deversifi')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'deversifi'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usd_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'deversifi'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
