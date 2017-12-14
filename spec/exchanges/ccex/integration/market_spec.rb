require 'spec_helper'

RSpec.describe 'Ccex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:usd_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'USD', target: 'BTC', market: 'ccex') }
  let(:terra_ltc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TERRA', target: 'LTC', market: 'ccex') }

  it 'fetch pairs' do
    pairs = client.pairs('ccex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'ccex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(usd_btc_pair)

    expect(ticker.base).to eq 'USD'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'ccex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker assign volume as zero if volume no longer exist' do
    ticker = client.ticker(terra_ltc_pair)

    expect(ticker.base).to eq 'TERRA'
    expect(ticker.target).to eq 'LTC'
    expect(ticker.market).to eq 'ccex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to eq 0
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
