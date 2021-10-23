require 'spec_helper'

RSpec.describe 'Synthetix integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:sbtc_seth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'sBTC', target: 'sETH', market: 'synthetix') }

  it 'fetch pairs' do
    pairs = client.pairs('synthetix')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'synthetix'
  end

  it 'fetch ticker' do
    ticker = client.ticker(sbtc_seth_pair)

    expect(ticker.base).to eq 'SBTC'
    expect(ticker.target).to eq 'SETH'
    expect(ticker.market).to eq 'synthetix'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
