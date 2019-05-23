require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Velic::Market do
  it { expect(described_class::NAME).to eq 'velic' }
  it { expect(described_class::API_URL).to eq 'https://api.velic.io/api/v1' }
end
