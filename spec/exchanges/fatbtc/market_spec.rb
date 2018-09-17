require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Fatbtc::Market do
  it { expect(described_class::NAME).to eq 'fatbtc' }
  it { expect(described_class::API_URL).to eq 'https://www.fatbtc.com/m' }
end
