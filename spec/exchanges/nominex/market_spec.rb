require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nominex::Market do
  it { expect(described_class::NAME).to eq 'nominex' }
  it { expect(described_class::API_URL).to eq 'https://nominex.io/api/rest/v1' }
end
