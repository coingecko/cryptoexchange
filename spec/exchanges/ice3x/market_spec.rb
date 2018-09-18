require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ice3x::Market do
  it { expect(described_class::NAME).to eq 'ice3x' }
  it { expect(described_class::API_URL).to eq 'https://ice3x.com/api/v1' }
end
