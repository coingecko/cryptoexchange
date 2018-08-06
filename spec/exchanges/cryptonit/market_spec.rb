require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cryptonit::Market do
  it { expect(described_class::NAME).to eq 'cryptonit' }
  it { expect(described_class::API_URL).to eq 'https://api.cryptonit.net/api' }
end
