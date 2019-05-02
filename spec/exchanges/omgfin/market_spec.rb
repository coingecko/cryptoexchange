require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Omgfin::Market do
  it { expect(described_class::NAME).to eq 'omgfin' }
  it { expect(described_class::API_URL).to eq 'https://omgfin.com/api/v1/ticker/24hr' }
end
