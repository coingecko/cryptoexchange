require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinfalcon::Market do
  it { expect(described_class::NAME).to eq 'coinfalcon' }
  it { expect(described_class::API_URL).to eq 'https://coinfalcon.com/api/v1/' }
end
