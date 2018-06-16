require 'spec_helper'

RSpec.describe 'StellarDex integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mobi_xlm_pair) do
    Cryptoexchange::Models::MarketPair.new(
      base: 'MOBI',
      target: 'XLM',
      market: Cryptoexchange::Exchanges::StellarDex::Market::NAME
    )
  end

  it 'fetch pairs' do
    pairs = client.pairs(Cryptoexchange::Exchanges::StellarDex::Market::NAME)
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq Cryptoexchange::Exchanges::StellarDex::Market::NAME
  end

  it 'fetch ticker' do
    ticker = client.ticker(mobi_xlm_pair)

    expect(ticker.base).to eq mobi_xlm_pair.base
    expect(ticker.target).to eq mobi_xlm_pair.target
    expect(ticker.market).to eq mobi_xlm_pair.market
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(ticker.volume).to_not be Numeric
  end
end
