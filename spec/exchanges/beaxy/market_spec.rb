require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Beaxy::Market do
  it { expect(described_class::NAME).to eq 'beaxy' }
  it { expect(described_class::API_URL).to eq 'https://api.beaxy.com/api/v1' }
end
