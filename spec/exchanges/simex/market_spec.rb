require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Simex::Market do
  it { expect(described_class::NAME).to eq 'simex' }
  it { expect(described_class::API_URL).to eq 'https://simex.global/api/pairs' }
end
