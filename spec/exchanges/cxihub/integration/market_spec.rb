require 'spec_helper'

RSpec.describe 'Cxihub integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'cxihub') }

  it 'fetch pairs' do
    pairs = client.pairs('cxihub')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'cxihub'
  end


  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'cxihub'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
