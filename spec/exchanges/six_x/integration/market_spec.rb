require 'spec_helper'

RSpec.describe 'SixX integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dcc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDX', market: 'six_x') }

  it 'fetch pairs' do
    pairs = client.pairs('six_x')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'six_x'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'six_x', base: dcc_eth_pair.base, target: dcc_eth_pair.target
    expect(trade_page_url).to eq "https://www.6x.com/market?symbol=BTC%2FUSDX&board=0"
  end

  it 'fetch ticker' do
    ticker = client.ticker(dcc_eth_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDX'
    expect(ticker.market).to eq 'six_x'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
