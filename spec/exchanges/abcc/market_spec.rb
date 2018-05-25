require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Abcc::Market do
  it { expect(described_class::NAME).to eq 'abcc' }
  it { expect(described_class::API_URL).to eq 'https://api.abcc.com/api/v2' }
end
