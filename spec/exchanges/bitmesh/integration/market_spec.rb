require 'spec_helper'

RSpec.describe 'Bitmesh integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitmesh' }
  let(:tera_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TERA', target: 'BTC', market: 'bitmesh') }

  it 'fetch pairs' do
    pairs = client.pairs('bitmesh')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitmesh'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: tera_btc_pair.base, target: tera_btc_pair.target
    expect(trade_page_url).to eq "https://bitmesh.com/exchange?market=btc_tera#/"
  end

  it 'fetch ticker' do
    ticker = client.ticker(tera_btc_pair)

    expect(ticker.base).to eq 'TERA'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitmesh'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
