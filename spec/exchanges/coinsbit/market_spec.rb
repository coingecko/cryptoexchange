require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinsbit::Market do
  it { expect(described_class::NAME).to eq 'coinsbit' }
  it { expect(described_class::API_URL).to eq 'https://coinsbit.io/api/v1' }
end
