require 'spec_helper'

RSpec.describe 'KyberNetwork integration specs' do
  client = Cryptoexchange::Client.new
  let(:knc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'knc', target: 'eth', market: 'kyber_network') }

  it 'fetch pairs' do
    pairs = client.pairs('kyber_network')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kyber_network'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'kyber_network', base: knc_eth_pair.base, target: knc_eth_pair.target
    expect(trade_page_url).to eq "https://kyber.network/swap/ETH_KNC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(knc_eth_pair)

    expect(ticker.base).to eq 'KNC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'kyber_network'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_nil
    expect(ticker.ask).to be_nil
    expect(ticker.high).to be_nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
