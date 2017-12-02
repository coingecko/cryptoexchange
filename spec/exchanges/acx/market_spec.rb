require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Acx::Market do
  it { expect(described_class::NAME).to eq 'acx' }
  it { expect(described_class::API_URL).to eq 'https://acx.io/api/v2' }
end
