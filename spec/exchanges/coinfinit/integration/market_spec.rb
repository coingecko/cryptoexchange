require 'spec_helper'

RSpec.describe 'Coinfinit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'KRW', market: 'coinfinit') }

  it 'fetch pairs' do
    pairs = client.pairs('coinfinit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinfinit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinfinit', base: btc_krw_pair.base, target: btc_krw_pair.target
    expect(trade_page_url).to eq "https://www.coinfinit.com/trade/order/krw-btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_krw_pair)

    expect(ticker.base).to eq btc_krw_pair.base
    expect(ticker.target).to eq btc_krw_pair.target
    expect(ticker.market).to eq btc_krw_pair.market
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric    
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
