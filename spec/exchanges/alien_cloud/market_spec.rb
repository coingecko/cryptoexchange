require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::AlienCloud::Market do
  it { expect(described_class::NAME).to eq 'alien_cloud' }
  it { expect(described_class::API_URL).to eq 'https://aliencloud.xyz/api/1.0' }
end
