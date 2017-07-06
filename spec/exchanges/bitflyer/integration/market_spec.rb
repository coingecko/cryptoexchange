require 'spec_helper'

RSpec.describe 'Bitflyer integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Bitflyer::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'JPY'
    expect(pair.market).to eq 'bitflyer'
  end

  it 'fetch ticker' do
    btc_jpy_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'jpy', market: 'bitflyer')
    ticker = Cryptoexchange::Exchanges::Bitflyer::Services::Market.new.fetch(btc_jpy_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'JPY'
    expect(ticker.market).to eq 'bitflyer'
    expect(ticker.last).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to_not be nil
    expect(ticker.payload).to_not be nil
  end
end
