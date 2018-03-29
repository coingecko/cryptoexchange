require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::KKex::Market do
  it { expect(described_class::NAME).to eq 'k_kex' }
  it { expect(described_class::API_URL).to eq 'https://kkex.com/api/v1' }
end
