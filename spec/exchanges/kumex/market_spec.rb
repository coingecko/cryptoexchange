require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kumex::Market do
  it { expect(described_class::NAME).to eq 'kumex' }
  it { expect(described_class::API_URL).to eq 'https://api.kumex.com/api/v1' }
end
