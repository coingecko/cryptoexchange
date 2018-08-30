require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinex::Market do
  it { expect(described_class::NAME).to eq 'coinex' }
  it { expect(described_class::API_URL).to eq 'https://api.coinex.com/v1' }
end
