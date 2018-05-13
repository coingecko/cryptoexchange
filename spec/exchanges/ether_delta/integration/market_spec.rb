require 'spec_helper'

RSpec.describe 'EtherDelta integration specs' do
  let(:client) { Cryptoexchange::Client.new }
  let(:ppt_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: 'PPT', target: 'ETH', market: 'ether_delta') }
  let(:ox_eth_pair) { Cryptoexchange::Models::MarketPair.new(base: '0X5A3C', target: 'ETH', market: 'ether_delta') }

  it 'fetch pairs' do
    pairs = client.pairs('ether_delta')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'ether_delta'
  end

  it 'does not include pairs with space or 0x' do
    pairs = client.pairs('ether_delta')
    pairs.each do |pair|
      expect(pair.base).to_not match /\s/
      expect(pair.base).to_not match /0x/
    end
  end

  it 'fetch pairs and assign the correct base/target' do
    pairs = client.pairs('ether_delta')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not eq 'ETH'
    expect(pair.market).to eq 'ether_delta'
  end

  it 'fetch ticker' do
    ticker = client.ticker(ppt_eth_pair)

    expect(ticker.base).to eq 'PPT'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'ether_delta'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end

  it 'fetch 0x ticker' do
    ticker = client.ticker(ox_eth_pair)
    expect(ticker.base).to eq '0X5A3C'
    expect(ticker.target).to eq 'ETH'
    expect(ticker.market).to eq 'ether_delta'
    expect(ticker.last).to be_a Numeric
    expect(ticker.bid).to be_a Numeric
    expect(ticker.ask).to be_a Numeric
    expect(ticker.volume).to be_a Numeric
    expect(ticker.timestamp).to be_a Numeric
    expect(2000..Date.today.year).to include(Time.at(ticker.timestamp).year)
    expect(ticker.payload).to_not be nil
  end
end
