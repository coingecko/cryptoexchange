require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Koinx::Market do
  it { expect(described_class::NAME).to eq 'koinx' }
  it { expect(described_class::API_URL).to eq 'https://koinx.id/api' }
end
