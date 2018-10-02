require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Wazirx::Market do
  it { expect(described_class::NAME).to eq 'wazirx' }
  it { expect(described_class::API_URL).to eq 'https://api.wazirx.com/api/v2' }
end
