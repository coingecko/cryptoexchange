require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Wex::Market do
  it { expect(described_class::NAME).to eq 'wex' }
  it { expect(described_class::API_URL).to eq 'https://wex.nz/api/3/' }
end
