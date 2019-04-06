require 'spec_helper'

RSpec.describe 'CoinMetro integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xcm_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'xcm', target: 'eur', market: 'coin_metro') }

  it 'fetch pairs' do
    pairs = client.pairs('coin_metro')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coin_metro'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url xcm_eur_pair.market, base: xcm_eur_pair.base, target: xcm_eur_pair.target
    expect(trade_page_url).to eq "https://go.coinmetro.com/#/trade"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xcm_eur_pair)
    expect(ticker.base).to eq 'XCM'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'coin_metro'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
