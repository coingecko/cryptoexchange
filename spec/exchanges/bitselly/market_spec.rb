require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitselly::Market do
  it { expect(described_class::NAME).to eq 'bitselly' }
  it { expect(described_class::API_URL).to eq 'https://api.bitselly.com/api/v1/public' }
end
