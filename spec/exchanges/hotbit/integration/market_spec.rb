require 'spec_helper'

RSpec.describe 'Hotbit Coin integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eng_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ENG', target: 'ETH', market: 'hotbit') }

  it 'fetch pairs' do
    pairs = client.pairs('hotbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'hotbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'hotbit', base: eng_eth_pair.base, target: eng_eth_pair.target
    expect(trade_page_url).to eq "https://www.hotbit.io/exchange?symbol=ENG_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eng_eth_pair)

    expect(ticker.base).to eq 'ENG'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'hotbit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
