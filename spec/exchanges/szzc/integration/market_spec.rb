require 'spec_helper'

RSpec.describe 'Szzc integration specs' do
  let(:client) { Cryptoexchange::Client.new }

  it 'fetch pairs' do
    pairs = client.pairs('szzc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pairs.map(&:target).uniq).to eq %w(CNY)
    expect(pairs.map(&:market).uniq).to eq %w(szzc)
  end

  it 'fetch ticker' do
    btc_cny_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'szzc')
    ticker = client.ticker(btc_cny_pair)

    expect(ticker.base).to_not be 'BTC'
    expect(ticker.target).to_not be 'CNY'
    expect(ticker.market).to eq 'szzc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
