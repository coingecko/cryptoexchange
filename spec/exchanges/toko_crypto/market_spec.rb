require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::TokoCrypto::Market do
  it { expect(described_class::NAME).to eq 'toko_crypto' }
  it { expect(described_class::API_URL).to eq 'https://api.tokocrypto.com/v1' }
end
