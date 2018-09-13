require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinmex::Market do
  it { expect(described_class::NAME).to eq 'coinmex' }
  it { expect(described_class::API_URL).to eq 'https://www.coinmex.com/api/v1' }
end
