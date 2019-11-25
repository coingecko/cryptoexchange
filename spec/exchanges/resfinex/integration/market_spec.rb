require 'spec_helper'

RSpec.describe 'resfinex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'resfinex' }
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', market: 'resfinex') }

  it 'fetch pairs' do
    pairs = client.pairs('resfinex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'resfinex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eth_usdt_pair.base, target: eth_usdt_pair.target
    expect(trade_page_url).to eq "https://trade.resfinex.com/?pair=ETH_USDT"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'resfinex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
