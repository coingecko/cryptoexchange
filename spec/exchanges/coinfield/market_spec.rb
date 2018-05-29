require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinfield::Market do
  it { expect(described_class::NAME).to eq 'coinfield' }
  it { expect(described_class::API_URL).to eq 'https://platform.coinfield.com/api/v2/' }
end