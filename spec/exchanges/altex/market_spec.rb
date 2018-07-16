require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Altex::Market do
  it { expect(described_class::NAME).to eq 'altex' }
  it { expect(described_class::API_URL).to eq 'https://api.altex.exchange/v1' }
end
