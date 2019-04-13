require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ethex::Market do
  it { expect(described_class::NAME).to eq 'ethex' }
  it { expect(described_class::API_URL).to eq 'https://api.ethex.market:5055' }
end
