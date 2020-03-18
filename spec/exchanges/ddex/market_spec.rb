require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ddex::Market do
  it { expect(described_class::NAME).to eq 'ddex' }
  it { expect(described_class::API_URL).to eq 'https://api.ddex.io/v4' }
end
