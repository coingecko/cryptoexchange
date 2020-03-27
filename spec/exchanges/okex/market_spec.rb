require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Okex::Market do
  it { expect(described_class::NAME).to eq 'okex' }
  it { expect(described_class::API_URL).to eq 'https://www.okex.com/api/spot/v3' }
end
