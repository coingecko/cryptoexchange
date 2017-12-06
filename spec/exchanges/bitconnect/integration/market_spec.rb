require 'spec_helper'

RSpec.describe 'Bitconnect integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:bcc_btc_pair) { Cryptoexchange::Models::MarketPair.new(base: 'BCC', target: 'BTC', market: 'bitconnect') }

  it 'fetch pairs' do
    pairs = client.pairs('bitconnect')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'bitconnect'
  end

  it 'fetch ticker' do
    ticker = client.ticker(bcc_btc_pair)

    expect(ticker.base).to eq 'BCC'
    expect(ticker.target).to eq 'BTC'
    expect(ticker.market).to eq 'bitconnect'
    expect(ticker.last).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.change).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
