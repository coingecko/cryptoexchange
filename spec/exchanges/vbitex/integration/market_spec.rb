require 'spec_helper'

RSpec.describe 'Vbitex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_vb_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'VB', market: 'vbitex') }

  it 'fetch pairs' do
    pairs = client.pairs('vbitex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vbitex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'vbitex', base: btc_vb_pair.base, target: btc_vb_pair.target
    expect(trade_page_url).to eq "http://www.vbitex.com/Home/Qcorders/index/currency/BTC.html"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_vb_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'VB'
    expect(ticker.market).to eq 'vbitex'
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
