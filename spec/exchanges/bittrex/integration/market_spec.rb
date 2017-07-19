require 'spec_helper'

RSpec.describe 'Bittrex integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('bittrex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bittrex'
  end

  it 'fetch ticker' do
    btc_ltc_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'ltc', market: 'bittrex')
    ticker = client.ticker(btc_ltc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'bittrex'
    expect(ticker.ask).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.last).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.low).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
