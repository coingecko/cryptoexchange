require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coss::Services::Pairs do
  it { expect(described_class::PAIRS_URL).to eq 'https://market.coss.io/api/ticker' }
end
