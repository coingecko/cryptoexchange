require 'spec_helper'

RSpec.describe 'KyberNetwork integration specs' do
  client = Cryptoexchange::Client.new
  let(:knc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'knc', target: 'eth', market: 'kyber_network') }

  it 'fetch pairs' do
    pairs = client.pairs('kyber_network')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kyber_network'
  end

  it 'fetch ticker' do
    ticker = client.ticker(knc_eth_pair)

    expect(ticker.base).to eq 'KNC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'kyber_network'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_nil
    expect(ticker.ask).to be_nil
    expect(ticker.high).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
