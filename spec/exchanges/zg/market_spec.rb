require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zg::Market do
  it { expect(described_class::NAME).to eq 'zg' }
  it { expect(described_class::API_URL).to eq 'https://api.zg8.com/openapi/quote/v1' }
end
