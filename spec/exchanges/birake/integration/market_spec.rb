require 'spec_helper'

RSpec.describe 'Birake integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bir_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BIR', target: 'BTC', market: 'birake') }

  it 'fetch pairs' do
    pairs = client.pairs('birake')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'birake'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bir_btc_pair)

    expect(ticker.base).to eq 'BIR'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'birake'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
