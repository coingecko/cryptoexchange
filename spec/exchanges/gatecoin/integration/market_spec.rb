require 'spec_helper'

RSpec.describe 'Gatecoin integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Gatecoin::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gatecoin'
  end

  it 'fetch ticker' do
    btc_hkd_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'HKD', market: 'gatecoin')
    ticker = Cryptoexchange::Exchanges::Gatecoin::Services::Market.new.fetch(btc_hkd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'HKD'
    expect(ticker.market).to eq 'gatecoin'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to_not be nil
    expect(ticker.payload).to_not be nil
  end
end
