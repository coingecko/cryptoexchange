require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ovex::Market do
  it { expect(described_class::NAME).to eq 'ovex' }
  it { expect(described_class::API_URL).to eq 'https://www.ovex.io/api/v2' }
end
