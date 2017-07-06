require 'spec_helper'

RSpec.describe 'Coincheck integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Coincheck::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'JPY'
    expect(pair.market).to eq 'coincheck'
  end

  it 'fetch ticker' do
    btc_jpy_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'jpy', market: 'coincheck')
    ticker = Cryptoexchange::Exchanges::Coincheck::Services::Market.new.fetch(btc_jpy_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'JPY'
    expect(ticker.market).to eq 'coincheck'
    expect(ticker.last).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.low).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to_not be nil
    expect(ticker.payload).to_not be nil
  end
end
