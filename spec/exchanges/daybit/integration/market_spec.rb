require 'spec_helper'

RSpec.describe 'Daybit integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:market) { 'daybit' }
  let(:eos_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'TRYBE', target: 'EOS', market: 'daybit') }

  it 'fetch pairs' do
    pairs = client.pairs('daybit')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be nil
    expect(pair.target).to_not be nil
    expect(pair.market).to eq 'daybit'
  end

  it 'give trade url' do
    trade_page_url = client.trade_page_url market, base: eos_eth_pair.base, target: eos_eth_pair.target
    expect(trade_page_url).to eq "https://daybit.com/exchange?quote=EOS&base=TRYBE"
  end

  it 'fetch ticker' do
    ticker = client.ticker(eos_eth_pair)

    expect(ticker.base).to eq 'TRYBE'
    expect(ticker.target).to eq 'EOS'
    expect(ticker.market).to eq 'daybit'
    expect(ticker.last).to be_a Numeric
    expect(ticker.high).to be_a Numeric
    expect(ticker.low).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be nil

    expect(ticker.payload).to_not be nil
  end
end
