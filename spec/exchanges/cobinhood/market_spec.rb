require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Cobinhood::Market do
  it { expect(described_class::NAME).to eq 'cobinhood' }
  it { expect(described_class::API_URL).to eq 'https://api.cobinhood.com/v1' }
end
