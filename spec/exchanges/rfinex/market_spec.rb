require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Rfinex::Market do
  it { expect(described_class::NAME).to eq 'rfinex' }
  it { expect(described_class::API_URL).to eq 'https://rfinex.com/api/v3' }
end
