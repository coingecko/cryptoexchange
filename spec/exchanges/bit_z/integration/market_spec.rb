require 'spec_helper'

RSpec.describe 'BitZ integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bit_z' }
  let(:ltc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ltc', target: 'btc', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs('bit_z')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'bit_z'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: ltc_btc_pair.base, target: ltc_btc_pair.target
    expect(trade_page_url).to eq "https://bitz.com/exchange/ltc_btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(ltc_btc_pair)

    expect(ticker.base).to eq 'LTC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bit_z'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
