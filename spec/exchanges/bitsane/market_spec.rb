require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitsane::Market do
  it { expect(described_class::NAME).to eq 'bitsane' }
  it { expect(described_class::API_URL).to eq 'https://bitsane.com/api/public' }
end
