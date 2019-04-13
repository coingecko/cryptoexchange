require 'spec_helper'

RSpec.describe 'TrxMarket integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ante_trx_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ante', target: 'trx', market: 'trx_market') }

  it 'fetch pairs' do
    pairs = client.pairs('trx_market')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'trx_market'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ante_trx_pair)

    expect(ticker.base).to eq 'ANTE'
    expect(ticker.target).to eq 'TRX'
    expect(ticker.market).to eq 'trx_market'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
