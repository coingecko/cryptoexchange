require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vb::Market do
  it { expect(described_class::NAME).to eq 'vb' }
  it { expect(described_class::API_URL).to eq 'https://api.vbt.cc/api/v1' }
end
