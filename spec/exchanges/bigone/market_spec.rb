require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bigone::Market do
  it { expect(described_class::NAME).to eq 'bigone' }
  it { expect(described_class::API_URL).to eq 'https://api.big.one' }
end
