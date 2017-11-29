require 'spec_helper'

RSpec.describe 'BitcoinIndonesia integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_idr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'idr', market: 'bitcoin_indonesia') }

  it 'fetch pairs' do
    pairs = client.pairs('bitcoin_indonesia')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'IDR'
    expect(pair.market).to eq 'bitcoin_indonesia'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_idr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'IDR'
    expect(ticker.market).to eq 'bitcoin_indonesia'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
