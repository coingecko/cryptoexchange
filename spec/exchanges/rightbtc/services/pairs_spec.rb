require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Rightbtc::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://www.rightbtc.com/api/public/trading_pairs' }
end
