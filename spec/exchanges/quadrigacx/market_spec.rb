require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Quadrigacx::Market do
  it { expect(described_class::NAME).to eq 'quadrigacx' }
  it { expect(described_class::API_URL).to eq 'https://api.quadrigacx.com/v2' }
end
