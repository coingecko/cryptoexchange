require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitso::Market do
  it { expect(described_class::NAME).to eq 'bitso' }
  it { expect(described_class::API_URL).to eq 'https://api.bitso.com/v3' }
end
