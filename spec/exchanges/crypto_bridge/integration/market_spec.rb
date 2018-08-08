require 'spec_helper'

RSpec.describe 'CryptoBridge integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bco_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCO', target: 'BTC', market: 'crypto_bridge') }

  it 'fetch pairs' do
    pairs = client.pairs('crypto_bridge')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'crypto_bridge'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bco_btc_pair)

    expect(ticker.base).to eq 'BCO'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'crypto_bridge'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'crypto_bridge', base: bco_btc_pair.base, target: bco_btc_pair.target
    expect(trade_page_url).to eq "https://wallet.crypto-bridge.org/market/BRIDGE.BCO_BRIDGE.BTC"
  end
end
