require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BitsBlockchain::Market do
  it { expect(described_class::NAME).to eq 'bits_blockchain' }
  it { expect(described_class::API_URL).to eq 'https://www.bitsblockchain.net/api/v1' }
end
