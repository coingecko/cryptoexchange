require 'spec_helper'

RSpec.describe 'Korbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'korbit' }
  let(:btc_krw_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'KRW', market: 'korbit') }

  it 'fetch pairs' do
    pairs = client.pairs('korbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'KRW'
    expect(pair.market).to eq 'korbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: btc_krw_pair.base, target: btc_krw_pair.target
    expect(trade_page_url).to eq "https://www.korbit.co.kr"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_krw_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'KRW'
    expect(ticker.market).to eq 'korbit'
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
