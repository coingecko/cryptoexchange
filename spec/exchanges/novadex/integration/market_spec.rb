require 'spec_helper'

RSpec.describe 'Novadex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:qtum_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'QTUM', target: 'BTC', market: 'novadex') }

  it 'fetch pairs' do

    pairs = client.pairs('novadex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'novadex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(qtum_btc_pair)

    expect(ticker.base).to eq 'QTUM'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'novadex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
