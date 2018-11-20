require 'spec_helper'

RSpec.describe 'Kineticex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_usd_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'USD', market: 'kineticex') }

  it 'fetch pairs' do
    pairs = client.pairs('kineticex')
    expect(pairs).not_to be_empty

    pair = pairs.sample
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'kineticex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'kineticex', base: btc_usd_pair.base, target: btc_usd_pair.target
    expect(trade_page_url).to eq "https://exchange.kineticex.com/btcusd?type=exchange"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_usd_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'USD'
    expect(ticker.market).to eq 'kineticex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    
    expect(ticker.payload).to_not be nil
  end
end
