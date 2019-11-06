require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bakkt::Market do
  it { expect(described_class::NAME).to eq 'bakkt' }
  it { expect(described_class::API_URL).to eq 'https://www.theice.com/marketdata' }
end
