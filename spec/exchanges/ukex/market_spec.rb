require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ukex::Market do
  it { expect(described_class::NAME).to eq 'ukex' }
  it { expect(described_class::API_URL).to eq 'https://api.ukex.com/api/index' }
end
