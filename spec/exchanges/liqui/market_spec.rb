require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Liqui::Market do
  it { expect(described_class::NAME).to eq 'liqui' }
  it { expect(described_class::API_URL).to eq 'https://api.liqui.io/api/3' }
end
