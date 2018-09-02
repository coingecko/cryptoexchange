require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Negociecoins::Market do
  it { expect(described_class::NAME).to eq 'negociecoins' }
  it { expect(described_class::API_URL).to eq 'https://broker.negociecoins.com.br/api/v3' }
end
