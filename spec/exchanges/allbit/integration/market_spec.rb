require 'spec_helper'

RSpec.describe 'Allbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dcc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'DCC', target: 'ETH', market: 'allbit') }

  it 'fetch pairs' do
    pairs = client.pairs('allbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'allbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'allbit', base: dcc_eth_pair.base, target: dcc_eth_pair.target
    expect(trade_page_url).to eq "https://allbit.com/exchange/DCC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(dcc_eth_pair)

    expect(ticker.base).to eq 'DCC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'allbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
