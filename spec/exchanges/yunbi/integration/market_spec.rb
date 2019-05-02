require 'spec_helper'

RSpec.describe 'Yunbi integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_cny_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'CNY', market: 'yunbi') }

  it 'fetch pairs' do
    pending ":error, yunbi's service is temporarily unavailable."

    pairs = client.pairs('yunbi')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'yunbi'
  end

  it 'fetch ticker' do
    pending ":error, yunbi's service is temporarily unavailable."

    ticker = client.ticker(btc_cny_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'CNY'
    expect(ticker.market).to eq 'yunbi'
    expect(ticker.last).to_not be nil
    expect(ticker.bid).to_not be nil
    expect(ticker.ask).to_not be nil
    expect(ticker.high).to_not be nil
    expect(ticker.volume).to_not be nil
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
