require 'spec_helper'

RSpec.describe 'Bitforex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitforex' }
  let(:btc_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USDT', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs('bitforex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitforex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_usdt_pair.base, target: btc_usdt_pair.target
    expect(trade_page_url).to eq 'https://www.bitforex.com/trade/spotTrading?commodityCode=BTC&currencyCode=USDT'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usdt_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'bitforex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
