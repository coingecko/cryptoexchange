require 'spec_helper'

RSpec.describe 'Coinlim integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', market: 'coinlim', inst_id: 49) }

  it 'fetch pairs' do
    pairs = client.pairs('coinlim')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinlim'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'coinlim'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
