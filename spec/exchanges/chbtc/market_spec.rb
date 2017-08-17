require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Chbtc::Market do
  it { expect(described_class::NAME).to eq 'chbtc' }
  it { expect(described_class::API_URL).to eq 'http://api.chbtc.com/data/v1' }
end
