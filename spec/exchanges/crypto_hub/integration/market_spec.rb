require 'spec_helper'

RSpec.describe 'CryptoHub integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bni_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BNI', target: 'BTC', market: 'crypto_hub') }

  it 'fetch pairs' do
    pairs = client.pairs('crypto_hub')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'crypto_hub'
  end


  it 'fetch ticker' do
    ticker = client.ticker(bni_btc_pair)

    expect(ticker.base).to eq 'BNI'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'crypto_hub'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
