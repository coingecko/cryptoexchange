require 'spec_helper'

RSpec.describe 'Litebiteu integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:btc_eur_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BTC', target: 'EUR', market: 'litebiteu') }

  it 'fetch pairs' do
    pairs = client.pairs('litebiteu')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to eq 'BTC'
    expect(pair.target).to eq 'EUR'
    expect(pair.market).to eq 'litebiteu'
  end

  it 'fetch ticker' do
    ticker = client.ticker(btc_eur_pair)

    expect(ticker.base).to eq 'BTC'
    expect(ticker.target).to eq 'EUR'
    expect(ticker.market).to eq 'litebiteu'

    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.last).to be_a Numeric
    expect(ticker.timestamp).to be_nil
    expect(ticker.payload).to_not be nil
  end
end
