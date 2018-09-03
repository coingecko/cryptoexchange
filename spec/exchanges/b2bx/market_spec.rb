require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::B2bx::Market do
  it { expect(described_class::NAME).to eq 'b2bx' }
  it { expect(described_class::API_URL).to eq 'https://api.b2bx.exchange/api/v1/b2trade/ticker' }
end
