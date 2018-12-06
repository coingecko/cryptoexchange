require 'spec_helper'

RSpec.describe 'Nusax integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'nusax' }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BTC', market: 'nusax') }

  it 'fetch pairs' do
    pairs = client.pairs('nusax')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'nusax'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: pair.base, target: pair.target
    expect(trade_page_url).to eq "https://nusax.co.id/trading/ETHBTC"
  end

  it 'fetch ticker' do
    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'nusax'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
