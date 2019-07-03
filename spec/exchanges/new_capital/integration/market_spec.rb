require 'spec_helper'

RSpec.describe 'NewCapital integration specs' do
  let(:client) {Cryptoexchange::Client.new}
  let(:twins_btc_pair) {Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'TWINS', market: 'new_capital')}

  it 'fetch pairs' do
    pairs = client.pairs('new_capital')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'new_capital'
  end

  it 'fetch ticker' do
    ticker = client.ticker(twins_btc_pair)
    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'TWINS'
    expect(ticker.market).to eq 'new_capital'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

end