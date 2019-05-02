require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bione::Market do
  it { expect(described_class::NAME).to eq 'bione' }
  it { expect(described_class::API_URL).to eq 'https://bione.cc/api/v2' }
end
