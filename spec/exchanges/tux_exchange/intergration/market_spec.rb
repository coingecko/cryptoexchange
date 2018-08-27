require 'spec_helper'

RSpec.describe 'TuxExchange integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:emc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EMC', target: 'BTC', market: 'tux_exchange') }

  it 'fetch pairs' do
    pairs = client.pairs('tux_exchange')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'tux_exchange'
  end

  it 'fetch ticker' do
    ticker = client.ticker(emc_btc_pair)

    expect(ticker.base).to eq 'EMC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'tux_exchange'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
