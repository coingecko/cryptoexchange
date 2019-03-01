require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CryptoexchangeWs::Market do
  it { expect(described_class::NAME).to eq 'cryptoexchange_ws' }
  it { expect(described_class::API_URL).to eq 'https://cryptoexchange.ws/en/gateway' }
end
