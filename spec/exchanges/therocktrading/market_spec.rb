require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Therocktrading::Market do
  it { expect(described_class::NAME).to eq 'therocktrading' }
  it { expect(described_class::API_URL).to eq 'https://www.therocktrading.com/api' }
end
