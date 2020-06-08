require 'spec_helper'

RSpec.describe 'Curve integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'DAI', target: 'USDT', market: 'curve') }

  let(:filename) { Cryptoexchange::Credentials.send(:filename) }

  before do
    allow(Cryptoexchange::Credentials).to receive(:get).with('curve').and_return({ 'api_key' => 'test_key' })
  end

  it 'fetch pairs' do
    pairs = client.pairs('curve')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).not_to be_nil
    expect(pair.target).not_to be_nil
    expect(pair.market).to eq 'curve'
  end

  it 'fetch ticker' do
    allow(Time).to receive(:now).and_return(Time.utc(2020, 2, 4))

    ticker = client.ticker(pair)

    expect(ticker.base).to eq 'DAI'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'curve'
    expect(ticker.last).to eq 1.00282886625
    expect(ticker.volume).to eq 707105.8709486402
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
