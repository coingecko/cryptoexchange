require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vaultmex::Market do
  it { expect(described_class::NAME).to eq 'vaultmex' }
  it { expect(described_class::API_URL).to eq 'https://vaultmex.com/v1' }
end
