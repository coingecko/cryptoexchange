require 'spec_helper'

RSpec.describe Cryptoexchange::Models::MarketPair do
  let(:pair) { Cryptoexchange::Models::MarketPair.new(base: 'btc', target: 'usd', market: 'market') }
  let(:numeric_pair) { Cryptoexchange::Models::MarketPair.new(base: 148, target: 'usd', market: 'market') }
  it { expect(pair.base).to eq 'BTC' }
  it { expect(pair.target).to eq 'USD' }
  it { expect(pair.market).to eq 'market' }

  it { expect(numeric_pair.base).to eq '148' }
  it { expect(numeric_pair.target).to eq 'USD' }
  it { expect(numeric_pair.market).to eq 'market' }
end
