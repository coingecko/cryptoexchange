require 'spec_helper'

RSpec.describe '9Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'btc', market: 'ninecoin') }

  it 'fetch pairs' do
    pending "9coin is broken"
    pairs = client.pairs('ninecoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ninecoin'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'ninecoin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
