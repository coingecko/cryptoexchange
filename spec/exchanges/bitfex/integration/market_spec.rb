require 'spec_helper'

RSpec.describe 'Bitfex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_rur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'RUR', market: 'bitfex') }

  it 'fetch pairs' do
    pairs = client.pairs('bitfex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'bitfex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'bitfex', base: btc_rur_pair.base, target: btc_rur_pair.target
    expect(trade_page_url).to eq 'https://bitfex.trade/en/BTC/RUR'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_rur_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'RUR'
    expect(ticker.market).to eq 'bitfex'

    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric

    expect(ticker.payload).to_not be nil
  end
end
