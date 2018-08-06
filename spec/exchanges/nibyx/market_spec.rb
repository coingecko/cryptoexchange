require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nibyx::Market do
  it { expect(described_class::NAME).to eq 'nibyx' }
  it { expect(described_class::API_URL).to eq 'https://nibyx.com/api/v1' }
end
