require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Nebula::Market do
  it { expect(described_class::NAME).to eq 'nebula' }
  it { expect(described_class::API_URL).to eq 'https://api.nebula.exchange' }
end
