require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Veridex::Market do
  it { expect(described_class::NAME).to eq 'veridex' }
  it { expect(described_class::API_URL).to eq 'https://dex-backend.verisafe.io/v2' }
end
