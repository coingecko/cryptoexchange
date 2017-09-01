require 'spec_helper'

RSpec.describe 'BxThailand integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('bx_thailand')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bx_thailand'
  end

  it 'fetch ticker' do
    btc_thb_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'THB', market: 'bx_thailand')
    ticker = client.ticker(btc_thb_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'THB'
    expect(ticker.market).to eq 'bx_thailand'
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
