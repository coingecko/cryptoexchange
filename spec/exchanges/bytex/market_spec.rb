require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bytex::Market do
  it { expect(described_class::NAME).to eq 'bytex' }
  it { expect(described_class::API_URL).to eq 'https://openapi.bytex.io/open/api' }
end
