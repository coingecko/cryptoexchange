require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chainrift::Market do
  it { expect(described_class::NAME).to eq 'chainrift' }
  it { expect(described_class::API_URL).to eq 'https://api.chainrift.com' }
end
