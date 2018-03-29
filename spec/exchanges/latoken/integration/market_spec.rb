require 'spec_helper'

RSpec.describe 'Latoken integration specs' do
  client = Cryptoexchange::Client.new
  let(:la_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'la', target: 'eth', market: 'latoken') }

  it 'fetch pairs' do
    pairs = client.pairs('latoken')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'latoken'
  end

  it 'fetch ticker' do
    ticker = client.ticker(la_eth_pair)

    expect(ticker.base).to eq 'LA'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'latoken'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
