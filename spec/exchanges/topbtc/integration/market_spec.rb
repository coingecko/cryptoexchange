require 'spec_helper'

RSpec.describe 'Topbtc integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:uqc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'UQC', target: 'BTC', market: 'topbtc') }

  it 'fetch pairs' do
    pairs = client.pairs('topbtc')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'topbtc'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'topbtc', base: uqc_btc_pair.base, target: uqc_btc_pair.target
    expect(trade_page_url).to eq "https://topbtc.com/home/market/index/market/BTC/coin/UQC.html"
  end

  it 'fetch ticker' do
    ticker = client.ticker(uqc_btc_pair)

    expect(ticker.base).to eq 'UQC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'topbtc'

    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric

    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
