require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fyrus::Market do
  it { expect(described_class::NAME).to eq 'fyrus' }
  it { expect(described_class::API_URL).to eq 'https://fyrus.pro/api/v1/market' }
end
