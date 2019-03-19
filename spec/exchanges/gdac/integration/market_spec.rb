require 'spec_helper'

RSpec.describe 'Gdac integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_bos_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'krw', market: 'gdac') }

  it 'fetch pairs' do
    pairs = client.pairs('gdac')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gdac'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_bos_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'gdac'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
