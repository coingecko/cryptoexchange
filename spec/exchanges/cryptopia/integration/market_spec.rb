require 'spec_helper'

RSpec.describe 'Cryptopia integration specs' do
  it 'fetch pairs' do
    pairs = Cryptoexchange::Exchanges::Cryptopia::Services::Pairs.new.fetch
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'cryptopia'
  end

  it 'fetch ticker' do
    btc_usdt_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'cryptopia')
    ticker = Cryptoexchange::Exchanges::Cryptopia::Services::Market.new.fetch(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'cryptopia'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.change).to_not be nil
    expect(ticker.timestamp).to_not be nil
    expect(ticker.payload).to_not be nil
  end
end
