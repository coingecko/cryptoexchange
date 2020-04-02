require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::LiquidDerivatives::Market do
  it { expect(described_class::NAME).to eq 'liquid_derivatives' }
  it { expect(described_class::API_URL).to eq 'https://api.liquid.com' }
end
