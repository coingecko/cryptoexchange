require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Prixbit::Market do
  it { expect(described_class::NAME).to eq 'prixbit' }
  it { expect(described_class::API_URL).to eq 'https://openapi.prixbit.com/openapi/v1' }
end
