require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hpx::Market do
  it { expect(described_class::NAME).to eq 'hpx' }
  it { expect(described_class::API_URL).to eq 'https://api.hpx.com/data/v2' }
end
