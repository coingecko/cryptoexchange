require 'spec_helper'

RSpec.describe 'Joyso integration specs' do
  client = Cryptoexchange::Client.new
  let(:eth_usdt_pair) { Cryptoexchange::Models::MarketPair.new(base: 'eth', target: 'usdt', market: 'joyso') }

  it 'fetch pairs' do
    pairs = client.pairs('joyso')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'joyso'
  end

  it 'fetch ticker' do
    ticker = client.ticker(eth_usdt_pair)

    expect(ticker.base).to eq 'ETH'
    expect(ticker.target).to eq 'USDT'
    expect(ticker.market).to eq 'joyso'
    expect(ticker.last).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
