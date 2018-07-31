require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Thetokenstore::Market do
  it { expect(described_class::NAME).to eq 'thetokenstore' }
  it { expect(described_class::API_URL).to eq 'https://v1-1.api.token.store' }
end
