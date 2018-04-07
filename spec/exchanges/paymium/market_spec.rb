require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paymium::Market do
  it { expect(described_class::NAME).to eq 'paymium' }
  it { expect(described_class::API_URL).to eq 'https://paymium.com/api/v1' }
end
