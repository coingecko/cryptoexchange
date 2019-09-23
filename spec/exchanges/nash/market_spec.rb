require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nash::Market do
  it { expect(described_class::NAME).to eq 'nash' }
  it { expect(described_class::API_URL).to eq 'https://app.nash.io/api' }
end
