require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptex::Market do
  it { expect(described_class::NAME).to eq 'cryptex' }
  it { expect(described_class::API_URL).to eq 'https://cryptex.net/api/v1' }
end
