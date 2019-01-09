require 'spec_helper'

RSpec.describe 'Drgx integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:drg_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DRG', target: 'BTC', market: 'drgx') }

  it 'fetch pairs' do
    pairs = client.pairs('drgx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'drgx'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'drgx', base: drg_btc_pair.base, target: drg_btc_pair.target
    expect(trade_page_url).to eq "https://drgx.io/exchange/trade.html#drg_btc"
  end

  it 'fetch pairs' do
    pairs = client.pairs('drgx')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'drgx'
  end

  it 'fetch ticker' do
    ticker = client.ticker(drg_btc_pair)

    expect(ticker.base).to eq 'DRG'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'drgx'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
