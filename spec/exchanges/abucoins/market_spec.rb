require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Abucoins::Market do
  it { expect(described_class::NAME).to eq 'abucoins' }
  it { expect(described_class::API_URL).to eq 'https://api.abucoins.com' }
end
