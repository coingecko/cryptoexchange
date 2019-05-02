require 'spec_helper'

RSpec.describe 'Jubi integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_cny_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'CNY', market: 'jubi') }

  it 'fetch pairs' do
    pairs = client.pairs('jubi')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'jubi'
  end

  it 'fetch ticker' do
    pending ":error=> jubi's service is temporarily unavailable."

    ticker = client.ticker(eth_cny_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'jubi'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
