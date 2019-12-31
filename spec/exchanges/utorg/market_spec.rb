require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Utorg::Market do
  it { expect(described_class::NAME).to eq 'utorg' }
  it { expect(described_class::API_URL).to eq 'https://public-api.utorg.io/api/v1' }
end
