require 'spec_helper'

RSpec.describe 'Zbmega integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'zbmega' }
  let(:xrp_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XRP', target: 'USDT', market: 'zbmega') }

  it 'fetch pairs' do
    pairs = client.pairs('zbmega')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'zbmega'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: xrp_usdt_pair.base, target: xrp_usdt_pair.target
    expect(trade_page_url).to eq "https://www.zbm.com/en/#/n/trade/xrp_usdt"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xrp_usdt_pair)

    expect(ticker.base).to eq 'XRP'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'zbmega'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
