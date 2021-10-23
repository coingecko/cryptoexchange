require 'spec_helper'

RSpec.describe 'Coinxpro integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'coinxpro' }
  let(:xrp_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XRP', target: 'BTC', market: 'coinxpro') }

  it 'fetch pairs' do
    pairs = client.pairs('coinxpro')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinxpro'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: xrp_btc_pair.base, target: xrp_btc_pair.target
    expect(trade_page_url).to eq "https://www.coinx.pro/trade/XRP_BTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xrp_btc_pair)

    expect(ticker.base).to eq 'XRP'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'coinxpro'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
