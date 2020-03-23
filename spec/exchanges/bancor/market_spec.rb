require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bancor::Market do
  it { expect(described_class::NAME).to eq 'bancor' }
  it { expect(described_class::API_URL).to eq 'https://api.bancor.network/0.1' }
end
