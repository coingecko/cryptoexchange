require 'spec_helper'

RSpec.describe 'Tokenlon integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bat_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BAT', target: 'ETH', market: 'tokenlon') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenlon')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenlon'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bat_eth_pair)

    expect(ticker.base).to eq 'BAT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'tokenlon'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
