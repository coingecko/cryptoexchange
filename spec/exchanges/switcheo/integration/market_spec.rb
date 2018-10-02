require 'spec_helper'

RSpec.describe 'Switcheo integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:mct_neo_pair) { Cryptoexchange::Models::MarketPair.new(base: 'MCT', target: 'NEO', market: 'switcheo') }

  it "invoke trade_page_url" do
    args = { base: "MCT", target: "NEO" }

    expect(Cryptoexchange::Exchanges::Switcheo::Market).to receive(:trade_page_url).with(args)
    client.trade_page_url('switcheo', args)
  end

  it 'fetch pairs' do
    pairs = client.pairs('switcheo')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'switcheo'
  end

  it 'fetch ticker' do
    ticker = client.ticker(mct_neo_pair)

    expect(ticker.base).to_not be 'MCT'
    expect(ticker.target).to_not be 'NEO'
    expect(ticker.market).to eq 'switcheo'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil
    expect(ticker.payload).to_not be nil
  end
end
