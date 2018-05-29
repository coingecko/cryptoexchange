require 'spec_helper'

RSpec.describe 'Coinfield integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_cad_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CAD', market: 'coinfield') }

  it 'fetch pairs' do
    pairs = client.pairs('coinfield')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinfield'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_cad_pair)

    expect(ticker.base).to eq btc_cad_pair.base
    expect(ticker.target).to eq btc_cad_pair.target
    expect(ticker.market).to eq btc_cad_pair.market
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end