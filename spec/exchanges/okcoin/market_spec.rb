require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Okcoin::Market do
  it { expect(described_class::NAME).to eq 'okcoin' }
  it { expect(described_class::API_URL).to eq 'https://www.okcoin.com/api/spot/v3' }
end
