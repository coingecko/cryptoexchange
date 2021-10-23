require 'spec_helper'

RSpec.describe 'Bitcratic integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'bitcratic' }
  let(:evc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EVC', target: 'ETH', market: 'bitcratic') }

  it 'fetch pairs' do
    pairs = client.pairs('bitcratic')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitcratic'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: evc_btc_pair.base, target: evc_btc_pair.target
    expect(trade_page_url).to eq "https://www.bitcratic.com/#!/trade/EVC-ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(evc_btc_pair)

    expect(ticker.base).to eq 'EVC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'bitcratic'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
