require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cashierest::Market do
  it { expect(described_class::NAME).to eq 'cashierest' }
  it { expect(described_class::API_URL).to eq 'https://rest.cashierest.com/public' }
end
