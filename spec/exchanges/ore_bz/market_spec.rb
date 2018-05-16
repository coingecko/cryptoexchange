require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OreBz::Market do
  it { expect(described_class::NAME).to eq 'ore_bz' }
  it { expect(described_class::API_URL).to eq 'https://ore.bz:443/api/v2' }
end
