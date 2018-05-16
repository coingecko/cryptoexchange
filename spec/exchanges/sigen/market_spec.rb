require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Sigen::Market do
  it { expect(described_class::NAME).to eq 'sigen' }
  it { expect(described_class::API_URL).to eq 'https://sigen.pro/v1/web-public/statistic' }
end
