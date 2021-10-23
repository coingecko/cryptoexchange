require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Mercuriex::Market do
  it { expect(described_class::NAME).to eq 'mercuriex' }
  it { expect(described_class::API_URL).to eq 'https://api.mercuriex.com/api/v0' }
end
