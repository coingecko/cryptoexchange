require 'spec_helper'

RSpec.describe 'Stellarport Integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:zrx_xlm_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ZRX', target: 'XLM', market: 'stellarport') }

  it 'fetch pairs' do
    pairs = client.pairs('stellarport')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'stellarport'
  end

  it 'fetch ticker' do
    ticker = client.ticker(zrx_xlm_pair)

    expect(ticker.base).to eq 'ZRX'
    expect(ticker.target).to eq 'XLM'
    expect(ticker.market).to eq 'stellarport'
    expect(ticker.change).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
