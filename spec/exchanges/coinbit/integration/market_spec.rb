require 'spec_helper'

RSpec.describe 'Coinbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'coinbit' }
  let(:tusd_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TUSD', target: 'KRW', market: 'coinbit') }

  it 'fetch pairs' do
    pairs = client.pairs('coinbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: tusd_krw_pair.base, target: tusd_krw_pair.target
    expect(trade_page_url).to eq "https://www.coinbit.co.kr/trade/order/krw-tusd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(tusd_krw_pair)

    expect(ticker.base).to eq 'TUSD'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'coinbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
