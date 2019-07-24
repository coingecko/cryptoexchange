require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DarbFinance::Market do
  it { expect(described_class::NAME).to eq 'darb_finance' }
  it { expect(described_class::API_URL).to eq 'https://api.darbfinance.com/api/v1' }
end
