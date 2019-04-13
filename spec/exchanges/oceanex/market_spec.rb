require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Oceanex::Market do
  it { expect(described_class::NAME).to eq 'oceanex' }
  it { expect(described_class::API_URL).to eq 'https://api.oceanex.pro/v1' }
end
