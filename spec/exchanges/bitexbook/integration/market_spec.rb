require 'spec_helper'

RSpec.describe 'Bitexbook integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'bitexbook') }

  it 'fetch pairs' do
    pairs = client.pairs('bitexbook')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitexbook'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitexbook', base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://bitexbook.com/trading/btcusd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'bitexbook'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
