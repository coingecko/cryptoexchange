require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Idax::Market do
  it { expect(described_class::NAME).to eq 'idax' }
  it { expect(described_class::API_URL).to eq 'https://openapi.idax.pro/api/v2' }
end
