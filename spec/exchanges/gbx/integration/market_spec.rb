require 'spec_helper'

RSpec.describe 'Gbx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bch_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'BTC', market: 'gbx') }

  it 'fetch pairs' do
    pairs = client.pairs('gbx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'gbx'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'gbx', base: bch_btc_pair.base, target: bch_btc_pair.target
    expect(trade_page_url).to eq "https://exchange.gbx.gi/trade?symbol=BCH%2FBTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_btc_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'gbx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
