require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BambooRelay::Market do
  it { expect(described_class::NAME).to eq 'bamboo_relay' }
  it { expect(described_class::API_URL).to eq 'https://rest.bamboorelay.com/main/0x' }
end
