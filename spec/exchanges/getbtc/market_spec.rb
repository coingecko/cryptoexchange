require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Getbtc::Market do
  it { expect(described_class::NAME).to eq 'getbtc' }
  it { expect(described_class::API_URL).to eq 'https://getbtc.org/api' }
end
