require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nuex::Market do
  it { expect(described_class::NAME).to eq 'nuex' }
  it { expect(described_class::API_URL).to eq 'https://api.nuex.com/api/v1' }
end
