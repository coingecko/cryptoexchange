require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TokenSets::Market do
  it { expect(described_class::NAME).to eq 'token_sets' }
  it { expect(described_class::API_URL).to eq 'https://api.tokensets.com/v1' }
end
