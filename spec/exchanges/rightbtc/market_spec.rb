require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Rightbtc::Market do
  it { expect(described_class::API_URL).to eq 'https://www.rightbtc.com/api/public' }
end
