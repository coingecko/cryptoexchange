require 'spec_helper'

RSpec.describe 'Etherflyer integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:tcash_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TCASH', target: 'ETH', market: 'Etherflyer') }

  it 'fetch pairs' do
    pairs = client.pairs('Etherflyer')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'TCASH'
    expect(pair.target).to eq 'ETH'
    expect(pair.market).to eq 'Etherflyer'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'Etherflyer', base: tcash_eth_pair.base, target: tcash_eth_pair.target
    expect(trade_page_url).to eq "https://www.etherflyer.com/trade.html?pairs=TCASH-ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(tcash_eth_pair)

    expect(ticker.base).to eq 'TCASH'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'Etherflyer'
    expect(ticker.last).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
