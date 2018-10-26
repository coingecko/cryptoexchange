require 'spec_helper'

RSpec.describe 'Hitbtc integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'hitbtc' }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'hitbtc') }

  it 'fetch pairs' do
    pairs = client.pairs('hitbtc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'hitbtc'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://hitbtc.com/BTC-to-USD"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'hitbtc'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
