require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitnaru::Market do
  it { expect(described_class::NAME).to eq 'bitnaru' }
  it { expect(described_class::API_URL).to eq 'https://market.bitnaru.com' }
end
