require 'spec_helper'

RSpec.describe 'Coinchangex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:stu_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'STU', target: 'ETH', market: 'coinchangex') }

  it 'fetch pairs' do
    pairs = client.pairs('coinchangex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'coinchangex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coinchangex', base: stu_eth_pair.base, target: stu_eth_pair.target
    expect(trade_page_url).to eq "https://www.coinchangex.com/#!/trade/STU-ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(stu_eth_pair)

    expect(ticker.base).to eq 'STU'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'coinchangex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
