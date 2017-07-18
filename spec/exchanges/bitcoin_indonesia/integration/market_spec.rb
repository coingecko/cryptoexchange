require 'spec_helper'

RSpec.describe 'BitcoinIndonesia integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('bitcoin_indonesia')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'IDR'
    expect(pair.market).to eq 'bitcoin_indonesia'
  end

  it 'fetch ticker' do
    btc_idr_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'idr', market: 'bitcoin_indonesia')
    ticker = client.ticker(btc_idr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'IDR'
    expect(ticker.market).to eq 'bitcoin_indonesia'
    expect(ticker.last).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.low).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
