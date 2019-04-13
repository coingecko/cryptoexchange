require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coindeal::Market do
  it { expect(described_class::NAME).to eq 'coindeal' }
  it { expect(described_class::API_URL).to eq 'https://apigateway.coindeal.com/api/v1/public' }
end
