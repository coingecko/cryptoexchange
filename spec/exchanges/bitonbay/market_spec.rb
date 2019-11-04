require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitonbay::Market do
  it { expect(described_class::NAME).to eq 'bitonbay' }
  it { expect(described_class::API_URL).to eq 'https://api.bitonbay.com/v1' }
end
