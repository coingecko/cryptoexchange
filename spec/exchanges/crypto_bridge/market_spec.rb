require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CryptoBridge::Market do
  it { expect(described_class::NAME).to eq 'crypto_bridge' }
  it { expect(described_class::API_URL).to eq 'https://api.crypto-bridge.org/api/v1' }
end
