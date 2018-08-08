require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::B2bx::Market do
  it { expect(described_class::NAME).to eq 'b2bx' }
  it { expect(described_class::API_URL).to eq 'https://cryptottlivewebapi.b2bx.exchange:8443/api/v1' }
end
