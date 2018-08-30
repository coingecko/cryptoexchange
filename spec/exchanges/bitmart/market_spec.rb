require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitmart::Market do
  it { expect(described_class::NAME).to eq 'bitmart' }
  it { expect(described_class::API_URL).to eq 'https://openapi.bitmart.com' }
end
