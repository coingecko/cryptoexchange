require 'spec_helper'

RSpec.describe 'Infinity Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xin_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XIN', target: 'BTC', market: 'infinity_coin') }

  it 'fetch pairs' do
    pairs = client.pairs('infinity_coin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'infinity_coin'
  end

  it 'fetch ticker' do
    ticker = client.ticker(xin_btc_pair)

    expect(ticker.base).to eq 'XIN'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'infinity_coin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
