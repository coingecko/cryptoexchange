require 'spec_helper'

RSpec.describe 'Bter integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_cny_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'cny', market: 'bter') }

  it 'fetch pairs' do
    pairs = client.pairs('bter')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'bter'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_cny_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'bter'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
