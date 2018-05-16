require 'spec_helper'

RSpec.describe 'Koinok integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_inr_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'inr', market: 'koinok') }

  it 'fetch pairs' do
    pairs = client.pairs('koinok')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'koinok'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_inr_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'INR'
    expect(ticker.market).to eq 'koinok'

    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.bid).to be_a Numeric 
    expect(ticker.ask).to be_a Numeric    

    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
