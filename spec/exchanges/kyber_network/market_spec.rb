require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::KyberNetwork::Market do
  it { expect(described_class::NAME).to eq 'kyber_network' }
  it { expect(described_class::API_URL).to eq 'https://api.kyber.network' }
end
