require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dakuce::Market do
  it { expect(described_class::NAME).to eq 'dakuce' }
  it { expect(described_class::API_URL).to eq 'https://dakuce.com/api/v1.0/public' }
end
