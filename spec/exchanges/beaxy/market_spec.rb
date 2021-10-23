require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Beaxy::Market do
  it { expect(described_class::NAME).to eq 'beaxy' }
  it { expect(described_class::API_URL).to eq 'https://services.beaxy.com/api/v2' }
end
