require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinlim::Market do
  it { expect(described_class::NAME).to eq 'coinlim' }
  it { expect(described_class::API_URL).to eq 'https://openapi.coinlim.com' }
end
