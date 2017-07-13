require 'spec_helper'

RSpec.describe 'ANX integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('anx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'anx'
  end

  it 'fetch ticker' do
    btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'anx')
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'anx'
    expect(ticker.last).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
