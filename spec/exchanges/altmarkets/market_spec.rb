require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Altmarkets::Market do
  it { expect(described_class::NAME).to eq 'altmarkets' }
  it { expect(described_class::API_URL).to eq 'https://altmarkets.io/api/v2' }
end
