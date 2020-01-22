require 'spec_helper'

RSpec.describe 'Tokenmom integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:tm_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TM', target: 'WETH', market: 'tokenmom') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenmom')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenmom'
  end

  it 'fetch ticker' do
    ticker = client.ticker(tm_weth_pair)

    expect(ticker.base).to eq 'TM'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'tokenmom'

    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric

    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
