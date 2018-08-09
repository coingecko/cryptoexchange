require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinsquare::Market do
  it { expect(described_class::NAME).to eq 'coinsquare' }
  it { expect(described_class::API_URL).to eq 'https://api.coinsquare.solutions/platform/internal/v1' }
end
