require 'spec_helper'

RSpec.describe 'SafeTrade integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:safe_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'SAFE', target: 'BTC', market: 'safe_trade') }

  it 'fetch pairs' do
    pairs = client.pairs('safe_trade')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'safe_trade'
  end

  it 'fetch ticker' do
    ticker = client.ticker(safe_btc_pair)

    expect(ticker.base).to eq 'SAFE'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'safe_trade'

    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
