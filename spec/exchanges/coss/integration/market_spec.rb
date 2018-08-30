require 'spec_helper'

RSpec.describe 'Coss integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:coss_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'COSS', target: 'ETH', market: 'coss') }

  it 'fetch pairs' do
    pairs = client.pairs('coss')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coss'
  end

  it 'fetch ticker' do
    ticker = client.ticker(coss_eth_pair)

    expect(ticker.base).to eq 'COSS'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'coss'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be nil
    expect(ticker.ask).to be nil
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coss', base: coss_eth_pair.base, target: coss_eth_pair.target
    expect(trade_page_url).to eq "https://exchange.coss.io/exchange/coss-eth"
  end
end
