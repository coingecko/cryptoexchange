require 'spec_helper'

RSpec.describe 'CoinsMarkets integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('coins_markets')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coins_markets'
  end

  it 'fetch ticker' do
    dog_xgtc_pair = Cryptoexchange::Models::MarketPair.new(base: 'DOG', target: 'XGTC', market: 'coins_markets')
    ticker = client.ticker(dog_xgtc_pair)

    expect(ticker.base).to eq 'DOG'
    expect(ticker.target).to eq 'XGTC'
    expect(ticker.market).to eq 'coins_markets'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
  #   expect(ticker.change).to be_a Numeric
  #   expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
