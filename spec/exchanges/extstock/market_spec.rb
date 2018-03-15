require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Extstock::Market do
  it { expect(described_class::NAME).to eq 'extstock' }
  it { expect(described_class::API_URL).to eq 'https://extstock.com/api/v1' }
end
