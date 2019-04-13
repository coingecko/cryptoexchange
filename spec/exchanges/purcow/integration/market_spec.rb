require 'spec_helper'

RSpec.describe 'Purcow integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: 'purcow') }

  it 'fetch pairs' do
    pairs = client.pairs 'purcow'
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'purcow'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'purcow', base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq "https://www.purcow.io/t/BTC_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq btc_usdt_pair.base
    expect(ticker.target).to eq btc_usdt_pair.target
    expect(ticker.market).to eq btc_usdt_pair.market
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
