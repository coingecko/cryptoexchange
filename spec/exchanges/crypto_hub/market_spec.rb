require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CryptoHub::Market do
  it { expect(described_class::NAME).to eq 'crypto_hub' }
  it { expect(described_class::API_URL).to eq 'https://cryptohub.online/api' }
end
