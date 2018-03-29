require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kuna::Market do
  it { expect(described_class::NAME).to eq 'kuna' }
  it { expect(described_class::API_URL).to eq 'https://kuna.io/api/v2' }
end
