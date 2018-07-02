require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Omnitrade::Market do
  it { expect(described_class::NAME).to eq 'omnitrade' }
  it { expect(described_class::API_URL).to eq 'https://omnitrade.io/api/v2' }
end
