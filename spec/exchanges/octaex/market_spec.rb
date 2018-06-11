require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Octaex::Market do
  it { expect(described_class::NAME).to eq 'octaex' }
  it { expect(described_class::API_URL).to eq 'https://octaex.com/api/trade' }
end
