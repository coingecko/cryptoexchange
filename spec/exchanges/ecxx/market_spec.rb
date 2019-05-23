require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Ecxx::Market do
  it { expect(described_class::NAME).to eq 'ecxx' }
  it { expect(described_class::API_URL).to eq 'https://www.ecxx.com/exapi/api/v1' }
end
