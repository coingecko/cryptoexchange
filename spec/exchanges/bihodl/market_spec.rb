require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bihodl::Market do
  it { expect(described_class::NAME).to eq 'bihodl' }
  it { expect(described_class::API_URL).to eq 'https://service.bihodl.com/market' }
end
