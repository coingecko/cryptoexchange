require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chiliz::Market do
  it { expect(described_class::NAME).to eq 'chiliz' }
  it { expect(described_class::API_URL).to eq 'https://api.chiliz.net/openapi/quote/v1' }
end
