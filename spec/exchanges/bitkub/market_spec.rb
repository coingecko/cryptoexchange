require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitkub::Market do
  it { expect(described_class::NAME).to eq 'bitkub' }
  it { expect(described_class::API_URL).to eq 'https://api.bitkub.com/api' }
end
