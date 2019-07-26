require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitci::Market do
  it { expect(described_class::NAME).to eq 'bitci' }
  it { expect(described_class::API_URL).to eq 'https://api.bitci.com/api' }
end
