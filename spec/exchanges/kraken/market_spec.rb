require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kraken::Market do
  it { expect(described_class::NAME).to eq 'kraken' }
  it { expect(described_class::API_URL).to eq 'https://api.kraken.com/0/public' }
end
