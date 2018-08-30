require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Gbx::Market do
  it { expect(described_class::NAME).to eq 'gbx' }
  it { expect(described_class::API_URL).to eq 'https://exchange.gbx.gi/api/v1' }
end
