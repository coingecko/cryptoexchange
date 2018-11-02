require 'spec_helper'

RSpec.describe 'Bitbegin integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_ngn_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'NGN', market: 'bitbegin') }

  it 'fetch pairs' do
    pairs = client.pairs('bitbegin')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitbegin'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitbegin', base: btc_ngn_pair.base, target: btc_ngn_pair.target
    expect(trade_page_url).to eq "https://bitbegin.io/trade?PairName=BTC-NGN"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_ngn_pair)
    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'NGN'
    expect(ticker.market).to eq 'bitbegin'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
