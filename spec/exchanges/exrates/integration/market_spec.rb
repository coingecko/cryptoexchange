require 'spec_helper'

RSpec.describe 'Exrates integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:lsk_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LSK', target: 'USD', market: 'exrates') }

  it 'fetch pairs' do
    pairs = client.pairs('exmo')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'exmo'
  end

  it 'fetch ticker' do
    ticker = client.ticker(lsk_usd_pair)

    expect(ticker.base).to eq 'LSK'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'exrates'
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
