require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitget::Market do
  it { expect(described_class::NAME).to eq 'bitget' }
  it { expect(described_class::API_URL).to eq 'https://api.bitget.cc/data/v1' }
end
