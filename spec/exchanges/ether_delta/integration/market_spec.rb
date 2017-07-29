require 'spec_helper'

RSpec.describe 'EtherDelta integration specs' do
  client = Cryptoexchange::Client.new

  it 'fetch pairs' do
    pairs = client.pairs('ether_delta')
    expect(pairs).not_to be_empty

    pair = pairs.first
    expect(pair.base).to_not be_nil
    expect(pair.target).to_not be_nil
    expect(pair.market).to eq 'ether_delta'
  end

  context 'fetch ticker' do
    before(:all) do
      eth_ppt_pair = Cryptoexchange::Models::MarketPair.new(base: 'ETH', target: 'PPT', market: 'ether_delta')
      @ticker = client.ticker(eth_ppt_pair)
    end
    it { expect(@ticker.base).to eq 'ETH' }
    it { expect(@ticker.target).to eq 'PPT' }
    it { expect(@ticker.market).to eq 'ether_delta' }
    it { expect(@ticker.last).to_not be nil }
    it { expect(@ticker.bid).to_not be nil }
    it { expect(@ticker.ask).to_not be nil }
    it { expect(@ticker.volume).to_not be nil }
    it { expect(@ticker.timestamp).to be_a Numeric }
    it { expect(@ticker.payload).to_not be nil }
  end
end
