require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::EtherDelta::Market do
  it { expect(described_class::NAME).to eq 'ether_delta' }
  it { expect(described_class::API_URL).to eq 'https://cache1.etherdelta.com' }
end
