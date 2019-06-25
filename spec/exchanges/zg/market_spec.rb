require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zg::Market do
  it { expect(described_class::NAME).to eq 'zg' }
  it { expect(described_class::API_URL).to eq 'https://www.zg.com/api/v1' }
end
