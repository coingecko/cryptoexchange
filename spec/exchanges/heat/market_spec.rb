require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Heat::Market do
  it { expect(described_class::NAME).to eq 'heat' }
  it { expect(described_class::API_URL).to eq 'https://heatwallet.com:7734/api/v1' }
end
