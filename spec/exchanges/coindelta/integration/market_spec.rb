require 'spec_helper'

RSpec.describe 'Coindelta integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_inr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'INR', market: 'coindelta') }

  it 'fetch pairs' do
    pairs = client.pairs('coindelta')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coindelta'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_inr_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'INR'
    expect(ticker.market).to eq 'coindelta'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
