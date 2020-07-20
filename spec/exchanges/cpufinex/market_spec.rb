require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cpufinex::Market do
  it { expect(described_class::NAME).to eq 'cpufinex' }
  it { expect(described_class::API_URL).to eq 'https://cpufinex.com/api/v2/trade' }
end
