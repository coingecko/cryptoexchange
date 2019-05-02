require 'spec_helper'

RSpec.describe 'Alterdice integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_adc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'Alterdice') }

  it 'fetch pairs' do
    pairs = client.pairs('Alterdice')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'Alterdice'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_adc_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'Alterdice'
    expect(ticker.last).to be_a Numeric
    # expect(ticker.bid).to be_a Numeric
    # expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
