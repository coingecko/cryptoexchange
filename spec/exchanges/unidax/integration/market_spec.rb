require 'spec_helper'

RSpec.describe 'Unidax integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'unidax' }
  let(:zrx_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ZRX', target: 'USDT', market: 'unidax') }

  it 'fetch pairs' do
    pairs = client.pairs('unidax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'unidax'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: zrx_usdt_pair.base, target: zrx_usdt_pair.target
    expect(trade_page_url).to eq "https://www.unidax.com/trade"
  end

  it 'fetch ticker' do
    ticker = client.ticker(zrx_usdt_pair)

    expect(ticker.base).to eq 'ZRX'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'unidax'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
