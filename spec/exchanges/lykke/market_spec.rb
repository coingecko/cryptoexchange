require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Lykke::Market do
  it { expect(described_class::NAME).to eq 'lykke' }
  it { expect(described_class::API_URL).to eq 'https://public-api.lykke.com/api' }
end
