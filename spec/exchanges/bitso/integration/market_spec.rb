require 'spec_helper'

RSpec.describe 'Bitso integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('bitso')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitso'
  end

  it 'fetch ticker' do
    btc_mxn_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'mxn', market: 'bitso')
    ticker = client.ticker(btc_mxn_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'MXN'
    expect(ticker.market).to eq 'bitso'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
