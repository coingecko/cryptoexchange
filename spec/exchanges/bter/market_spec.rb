require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bter::Market do
  it { expect(described_class::NAME).to eq 'bter' }
  it { expect(described_class::API_URL).to eq 'https://data.bter.com/api2/1' }
end
