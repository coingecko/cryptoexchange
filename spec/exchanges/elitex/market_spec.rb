require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Elitex::Market do
  it { expect(described_class::NAME).to eq 'elitex' }
  it { expect(described_class::API_URL).to eq 'https://api.elitex.io/api/v1' }
end
