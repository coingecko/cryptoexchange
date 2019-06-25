require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::StakeCube::Market do
  it { expect(described_class::NAME).to eq 'stake_cube' }
  it { expect(described_class::API_URL).to eq 'https://stakecube.net/api/v1' }
end
