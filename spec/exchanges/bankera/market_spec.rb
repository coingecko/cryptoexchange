require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bankera::Market do
  it { expect(described_class::NAME).to eq 'bankera' }
  it { expect(described_class::API_URL).to eq 'https://api-exchange.bankera.com' }
end
