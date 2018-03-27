require 'spec_helper'

RSpec.describe 'Nanex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_nano_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'nano', market: 'nanex') }

  it 'fetch pairs' do
    pairs = client.pairs('nanex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'nanex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_nano_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'NANO'
    expect(ticker.market).to eq 'nanex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
