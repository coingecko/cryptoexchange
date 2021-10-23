require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StocksExchange::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://api3.stex.com/public/ticker' }
end
