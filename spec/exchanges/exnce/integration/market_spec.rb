require 'spec_helper'

RSpec.describe 'Exnce integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:xlm_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'XLM', target: 'ETH', market: 'exnce') }

  it 'fetch pairs' do
    pairs = client.pairs('exnce')
    expect(pairs).not_to be_empty
    pair = pairs.first
    expect(pair.base).to eq 'XLM'
    expect(pair.target).to eq 'ETH'
    expect(pair.market).to eq 'exnce'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'exnce', base: xlm_eth_pair.base, target: xlm_eth_pair.target
    expect(trade_page_url).to eq "https://exnce.com/market/XLM-ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(xlm_eth_pair)

    expect(ticker.base).to eq 'XLM'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'exnce'
    expect(ticker.last).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
