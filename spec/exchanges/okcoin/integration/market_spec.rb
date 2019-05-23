require 'spec_helper'

RSpec.describe 'Okcoin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'okcoin') }
  let(:btc_cny_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'okcoin') }

  it 'fetch pairs' do
    pairs = client.pairs('okcoin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'USD'
    expect(pair.market).to eq 'okcoin'
  end

  it 'fetch ticker USD' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'okcoin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fetch ticker CNY' do
    ticker = client.ticker(btc_cny_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'okcoin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
