require 'spec_helper'

RSpec.describe 'Btcc integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('btcc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'USD'
    expect(pair.market).to eq 'btcc'
  end

  it 'fetch ticker' do
    btc_usd_pair = Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'btcc')
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'btcc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end
end
