require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitsoda::Market do
  it { expect(described_class::NAME).to eq 'bitsoda' }
  it { expect(described_class::API_URL).to eq 'https://api.bitsoda.com/v1' }
end
