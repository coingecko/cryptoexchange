require 'spec_helper'

RSpec.describe 'Ecxx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'ecxx' }
  let(:eth_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'ecxx') }

  it 'fetch pairs' do
    pairs = client.pairs('ecxx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'ecxx'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eth_btc_pair.base, target: eth_btc_pair.target
    expect(trade_page_url).to eq "https://www.ecxx.com/tradingview?symbol=ETH_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_btc_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'ecxx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
