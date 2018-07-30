require 'spec_helper'

RSpec.describe 'Hikenex Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'BTC', market: 'hikenex') }

  it 'fetch pairs' do
    pairs = client.pairs('hikenex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hikenex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'hikenex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
