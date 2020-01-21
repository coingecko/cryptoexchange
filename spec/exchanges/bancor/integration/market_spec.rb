require 'spec_helper'

RSpec.describe 'Bancor integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:eth_bnt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'BNT', market: 'bancor') }

  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('bancor').and_return({ 'api_key' => 'api_key' })
  end

  it 'fetch pairs' do
    pairs = client.pairs('bancor')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bancor'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_bnt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'BNT'
    expect(ticker.market).to eq 'bancor'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
