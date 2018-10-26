require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Deex::Market do
  it { expect(described_class::NAME).to eq 'deex' }
  it { expect(described_class::API_URL).to eq 'https://stat-api.deex.exchange:2087' }
end
