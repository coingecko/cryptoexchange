require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chainex::Market do
  it { expect(described_class::NAME).to eq 'chainex' }
  it { expect(described_class::API_URL).to eq 'https://api.chainex.io' }
end
