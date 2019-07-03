require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Swiftex::Market do
  it { expect(described_class::NAME).to eq 'swiftex' }
  it { expect(described_class::API_URL).to eq 'https://trade.swiftex.co/api/v2/peatio/public' }
end
