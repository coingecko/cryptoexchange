require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Oex::Market do
  it { expect(described_class::NAME).to eq 'oex' }
  it { expect(described_class::API_URL).to eq 'https://openapi.oex.com/open/api' }
end