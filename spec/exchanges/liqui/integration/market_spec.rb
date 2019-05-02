require 'spec_helper'

RSpec.describe 'Liqui integration specs' do
  let(:client) {  Cryptoexchange::Client.new }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'LTC', target: 'BTC', market: 'liqui') }

  it 'fetch pairs' do
    pairs = client.pairs('liqui')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'liqui'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'liqui'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'fail to parse ticker' do
    expect { client.ticker(Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'ltc', market: 'liqui')) }.to raise_error(Cryptoexchange::ResultParseError)
  end
end
