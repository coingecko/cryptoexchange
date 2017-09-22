require 'spec_helper'

RSpec.describe 'Luno integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('luno')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'luno'
  end

  it 'fetch ticker' do
    pair = Cryptoexchange::Models::MarketPair.new(base: 'XBT', target: 'ZAR', market: 'luno')
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'XBT'
    expect(ticker.target).to eq 'ZAR'
    expect(ticker.market).to eq 'luno'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_nil
    expect(ticker.low).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
