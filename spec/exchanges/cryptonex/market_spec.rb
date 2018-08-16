require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptonex::Market do
  it { expect(described_class::NAME).to eq 'cryptonex' }
  it { expect(described_class::API_URL).to eq 'https://userapi.cryptonex.org/api' }
end
