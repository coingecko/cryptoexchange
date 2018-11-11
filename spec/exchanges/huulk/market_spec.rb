require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Huulk::Market do
  it { expect(described_class::NAME).to eq 'huulk' }
  it { expect(described_class::API_URL).to eq 'https://huulk.com/api/public/market' }
end
