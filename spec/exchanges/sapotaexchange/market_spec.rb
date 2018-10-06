require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Sapotaexchange::Market do
  it { expect(described_class::NAME).to eq 'sapotaexchange' }
  it { expect(described_class::API_URL).to eq 'https://sapotaexchange.com/api/v2' }
end
