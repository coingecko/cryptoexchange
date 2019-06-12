require 'spec_helper'

RSpec.describe 'Mercuriex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:zano_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ZANO', target: 'BTC', market: 'mercuriex') }

  it 'fetch pairs' do
    pairs = client.pairs('mercuriex')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'mercuriex'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'mercuriex', base: zano_btc_pair.base, target: zano_btc_pair.target
    expect(trade_page_url).to eq "https://mercuriex.com/trade/#pair=zano.btc"
  end

  it 'fetch ticker' do
    ticker = client.ticker(zano_btc_pair)

    expect(ticker.base).to eq 'ZANO'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'mercuriex'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
