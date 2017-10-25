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

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('bleutrade')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'ADC'
    expect(pair.target).to eq 'BTC'
    expect(pair.market).to eq 'bleutrade'
  end

  it 'fetch ticker' do
    btc_adc_pair = Cryptoexchange::Models::MarketPair.new(base: 'ADC', target: 'BTC', market: 'bleutrade')
    ticker = client.ticker(btc_adc_pair)

    expect(ticker.base).to eq 'ADC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bleutrade'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(DateTime.strptime(ticker.timestamp.to_s, '%s').year).to eq Date.today.year
    expect(ticker.payload).to_not be nil
  end
end
