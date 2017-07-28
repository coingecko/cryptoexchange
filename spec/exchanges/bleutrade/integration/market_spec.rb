require 'spec_helper'

RSpec.describe 'Bleutrade integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('bleutrade')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bleutrade'
  end

  it 'fetch ticker' do
    btc_adc_pair = Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'adc', market: 'bleutrade')
    ticker = client.ticker(btc_adc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ADC'
    expect(ticker.market).to eq 'bleutrade'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
