require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinbig::Market do
  it { expect(described_class::NAME).to eq 'coinbig' }
  it { expect(described_class::API_URL).to eq 'https://www.coinbig.com/api/publics/v1' }
end
