require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Switcheo::Market do
  it { expect(described_class::NAME).to eq 'switcheo' }
  it { expect(described_class::API_URL).to eq 'https://api.switcheo.network' }
end
