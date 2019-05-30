require 'spec_helper'

RSpec.describe 'NebliDex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_nebl_pair) { Cryptoexchange::Models::MarketPair.new(base: 'NEBL', target: 'BTC', market: 'neblidex') }

  it 'fetch pairs' do
    pairs = client.pairs('neblidex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'neblidex'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_nebl_pair)

    expect(ticker.base).to eq 'NEBL'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'neblidex'

    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric

    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
