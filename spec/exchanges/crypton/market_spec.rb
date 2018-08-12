require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Crypton::Market do
  it { expect(described_class::NAME).to eq 'crypton' }
  it { expect(described_class::API_URL).to eq 'https://api.cryptonbtc.com' }
end
