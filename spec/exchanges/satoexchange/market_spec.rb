require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Satoexchange::Market do
  it { expect(described_class::NAME).to eq 'satoexchange' }
  it { expect(described_class::API_URL).to eq 'https://www.satoexchange.com/api/v1' }
end
