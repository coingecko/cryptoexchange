require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::SaturnNetwork::Market do
  it { expect(described_class::NAME).to eq 'saturn_network' }
  it { expect(described_class::API_URL).to eq 'https://ticker.saturn.network' }
end
