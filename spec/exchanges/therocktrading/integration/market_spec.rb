require 'spec_helper'

RSpec.describe 'Therocktrading integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pairs) { client.pairs('therocktrading') }
  let(:pair) { pairs.first }
  let(:btc_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'EUR', market: 'therocktrading') }
  let(:usd_xrp_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EUR', target: 'XRP', market: 'therocktrading') }

  it 'fetch pairs' do
    expect(pairs).not_to be_empty
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'therocktrading'
  end

  it 'use pair from pairs to fetch ticker' do
    ticker = client.ticker(pair)
    expect(ticker).to_not be nil
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eur_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'therocktrading'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker (XRP is not treated as Base)' do
    ticker = client.ticker(usd_xrp_pair)

    expect(ticker.base).to eq 'EUR'
    expect(ticker.target).to eq 'XRP'
    expect(ticker.market).to eq 'therocktrading'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end

end
