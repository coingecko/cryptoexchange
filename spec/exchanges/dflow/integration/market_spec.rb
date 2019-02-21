require 'spec_helper'

RSpec.describe 'Dflow integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USDT', market: 'dflow') }

  it 'fetch pairs' do
    pairs = client.pairs('dflow')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'dflow'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'dflow', base: "ETH", target: "USDT"
    expect(trade_page_url).to eq "https://dflowx.com/Exchange"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'dflow'

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
