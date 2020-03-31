require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::DexBlue::Market do
  it { expect(described_class::NAME).to eq 'dex_blue' }
  it { expect(described_class::API_URL).to eq 'https://api.dex.blue/rest/v1' }
end
