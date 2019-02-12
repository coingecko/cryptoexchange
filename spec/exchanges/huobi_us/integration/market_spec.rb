require 'spec_helper'

RSpec.describe 'HuobiUs integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'huobi_us' }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'USD', market: 'huobi_us') }

  it 'fetch pairs' do
    pairs = client.pairs('huobi_us')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'huobi_us'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://www.huobi.com/markets/?symbols=eth_usd"
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'huobi_us'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
