require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ccore::Market do
  it { expect(described_class::NAME).to eq 'ccore' }
  it { expect(described_class::API_URL).to eq 'https://websitewebapi.ccore.io' }
end
