require 'spec_helper'

RSpec.describe 'Tokenize integration specs' do
  client = Cryptoexchange::Client.new
  let(:btc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'btc', market: 'tokenize') }

  it 'fetch pairs' do
    pairs = client.pairs('tokenize')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'tokenize'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'tokenize'

    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric

    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'tokenize', base: btc_eth_pair.base, target: btc_eth_pair.target
    expect(trade_page_url).to eq "https://tokenize.exchange/market/BTC-ETH"
  end  
end
