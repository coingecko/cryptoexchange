require 'spec_helper'

RSpec.describe 'Kraken integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'kraken' }
  let(:bch_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCH', target: 'EUR', market: 'kraken') }

  it 'fetch pairs' do
    pairs = client.pairs('kraken')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kraken'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: bch_eur_pair.base, target: bch_eur_pair.target
    expect(trade_page_url).to eq "https://trade.kraken.com/markets/kraken/bch/eur"
  end

  it 'fetch ticker' do
    ticker = client.ticker(bch_eur_pair)

    expect(ticker.base).to eq 'BCH'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'kraken'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
