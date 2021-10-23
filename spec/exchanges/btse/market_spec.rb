require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btse::Market do
  it { expect(described_class::NAME).to eq 'btse' }
  it { expect(described_class::API_URL).to eq 'https://api.btse.com/spot/v2' }
end
