require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nexybit::Market do
  it { expect(described_class::NAME).to eq 'nexybit' }
  it { expect(described_class::API_URL).to eq 'https://api.nexybit.com/api/spot/v1' }
end
