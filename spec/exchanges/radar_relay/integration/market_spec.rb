require 'spec_helper'

RSpec.describe 'RadarRelay integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:dai_weth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'dai', target: 'weth', market: 'radar_relay') }

  it 'fetch pairs' do
    pairs = client.pairs('radar_relay')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'radar_relay'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'radar_relay', base: dai_weth_pair.base, target: dai_weth_pair.target
    expect(trade_page_url).to eq "https://app.radarrelay.com/DAI/WETH"
  end

  it 'fetch ticker' do
    ticker = client.ticker(dai_weth_pair)

    expect(ticker.base).to eq 'DAI'
    expect(ticker.target).to eq 'WETH'
    expect(ticker.market).to eq 'radar_relay'
    expect(ticker.last).to be_a Numeric
    expect(ticker.last).to be < 100 # Test if number is reasonable
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
