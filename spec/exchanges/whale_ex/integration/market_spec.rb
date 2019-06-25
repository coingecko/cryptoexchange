require 'spec_helper'

RSpec.describe 'WhaleEx integration specs' do
  let(:market) { "whale_ex" }
  let(:client) { Cryptoexchange::Client.new }
  let(:eos_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'EOS', target: 'BTC', market: market) }

  it 'fetch pairs' do
    pairs = client.pairs market
    expect(pairs).not_to be_empty

    expect(pairs[0].base).to_not be nil
    expect(pairs[0].target).to_not be nil
    expect(pairs[0].market).to eq market
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_btc_pair)

    expect(ticker.base).to eq eos_btc_pair.base
    expect(ticker.target).to eq eos_btc_pair.target
    expect(ticker.market).to eq eos_btc_pair.market
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.volume).to be_a Numeric
    expect(ticker.payload).to_not be nil
  end
end
