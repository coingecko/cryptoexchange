require 'spec_helper'

RSpec.describe 'Vinex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'ETH', market: 'vinex') }

  it 'fetch pairs' do
    pairs = client.pairs('vinex')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'vinex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'vinex', base: "BTC", target: "ETH"
    expect(trade_page_url).to eq "https://vinex.network/market/BTC_ETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eth_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'vinex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
