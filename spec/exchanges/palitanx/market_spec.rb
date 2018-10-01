require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Palitanx::Market do
  it { expect(described_class::NAME).to eq 'palitanx' }
  it { expect(described_class::API_URL).to eq 'https://api.palitanx.com/v1/public' }
end
