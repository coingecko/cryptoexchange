require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CompoundFinance::Market do
  it { expect(described_class::NAME).to eq 'compound_finance' }
  it { expect(described_class::API_URL).to eq 'https://api.compound.finance/api/v2' }
end
