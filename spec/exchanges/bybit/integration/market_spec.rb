require 'spec_helper'

RSpec.describe 'Bybit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'bybit') }

  it 'fetch pairs' do
    pairs = client.pairs('bybit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bybit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bybit', base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://www.bybit.com/app/exchange/BTCUSD"
  end

  #skip for now
  xit 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'bybit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
