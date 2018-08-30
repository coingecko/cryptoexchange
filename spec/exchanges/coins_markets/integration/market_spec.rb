require 'spec_helper'

RSpec.describe 'CoinsMarkets integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dog_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DOG', target: 'BTC', market: 'coins_markets') }

  it 'fetch pairs' do
    pairs = client.pairs('coins_markets')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coins_markets'
  end

  it 'fetch ticker' do
    ticker = client.ticker(dog_btc_pair)

    expect(ticker.base).to eq 'DOG'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'coins_markets'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
