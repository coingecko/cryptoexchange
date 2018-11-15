require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Alterdice::Market do
  it { expect(described_class::NAME).to eq 'Alterdice' }
  it { expect(described_class::API_URL).to eq 'https://api.alterdice.com/v1' }
end
