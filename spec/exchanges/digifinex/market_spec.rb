require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Digifinex::Market do
  it { expect(described_class::NAME).to eq 'digifinex' }
  it { expect(described_class::API_URL).to eq 'https://data.block.cc/api/v1' }
end
