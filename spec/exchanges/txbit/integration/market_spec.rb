require 'spec_helper'

RSpec.describe 'Txbit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'txbit' }
  let(:btc_atl_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'atl', market: 'txbit') }

  it 'fetch pairs' do
    pairs = client.pairs('txbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'txbit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, target: btc_atl_pair.target, base: btc_atl_pair.base
    expect(trade_page_url).to eq "https://txbit.io/Trade/ATL/BTC"
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('txbit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'ATL'
    expect(pair.market).to eq 'txbit'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_atl_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ATL'
    expect(ticker.market).to eq 'txbit'
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fail to parse ticker' do
    expect { client.ticker(Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'xxxxx', market: 'txbit')) }.to raise_error(Cryptoexchange::ResultParseError)
  end
end
