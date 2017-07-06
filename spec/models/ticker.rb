require 'spec_helper'

RSpec.describe Cryptoexchange::Models::Ticker do
  let(:ticker) { Cryptoexchange::Models::Ticker.new(base: 'btc', target: 'usd', market: 'market') }
  it { expect(ticker.base).to eq 'BTC' }
  it { expect(ticker.target).to eq 'USD' }
end
