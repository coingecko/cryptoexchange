require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::LiquidPerpetual::Market do
  it { expect(described_class::NAME).to eq 'liquid_perpetual' }
  it { expect(described_class::API_URL).to eq 'https://api.liquid.com' }
end
