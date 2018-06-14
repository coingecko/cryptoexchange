require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coin2001::Market do
  it { expect(described_class::NAME).to eq 'coin2001' }
  it { expect(described_class::API_URL).to eq 'https://coin2001.com/api' }
end
