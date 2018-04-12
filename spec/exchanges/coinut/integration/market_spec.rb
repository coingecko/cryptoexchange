require 'spec_helper'

RSpec.describe 'Coinut integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_sgd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'SGD', market: 'coinut', inst_id: "852380") }

  it 'fetch pairs' do
    pairs = client.pairs('coinut')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinut'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_sgd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'SGD'
    expect(ticker.market).to eq 'coinut'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be nil
    expect(ticker.ask).to be nil
    expect(ticker.change).to be nil
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
