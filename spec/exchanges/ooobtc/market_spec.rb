require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ooobtc::Market do
  it { expect(described_class::NAME).to eq 'ooobtc' }
  it { expect(described_class::API_URL).to eq 'https://api.ooobtc.com/open' }
end
