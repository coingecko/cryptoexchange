require 'spec_helper'

RSpec.describe 'Airswap integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dai_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'dai', target: 'eth', market: 'airswap') }

  it 'fetch pairs' do
    pairs = client.pairs('airswap')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'airswap'
  end

  it 'fetch ticker' do
    ticker = client.ticker(dai_eth_pair)

    expect(ticker.base).to eq 'DAI'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'airswap'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric

    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
