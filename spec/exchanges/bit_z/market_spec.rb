require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitZ::Market do
  it { expect(described_class::NAME).to eq 'bit_z' }
  it { expect(described_class::API_URL).to eq 'https://api.bit-z.com/api_v1' }
end
