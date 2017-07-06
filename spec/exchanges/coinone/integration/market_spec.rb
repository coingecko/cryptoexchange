require 'spec_helper'

RSpec.describe 'Coinone integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Coinone::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinone'
  end

  it 'fetch ticker' do
    eth_krw_pair = Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'krw', market: 'coinone')
    ticker = Cryptoexchange::Exchanges::Coinone::Services::Market.new.fetch(eth_krw_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'coinone'
    expect(ticker.last).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.low).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to_not be nil
    expect(ticker.payload).to_not be nil
  end
end
