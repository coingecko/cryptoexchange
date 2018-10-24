require 'spec_helper'

RSpec.describe 'Coindirect integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_zar_pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'zar', market: 'coindirect') }

  it 'fetch pairs' do
    pairs = client.pairs('coindirect')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'ZAR'
    expect(pair.market).to eq 'coindirect'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url 'coindirect', base: btc_zar_pair.base, target: btc_zar_pair.target
    expect(trade_page_url).to eq "https://exchange.coindirect.com/btc-zar"
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_zar_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'ZAR'
    expect(ticker.market).to eq 'coindirect'
    expect(ticker.last).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
