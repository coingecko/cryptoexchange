require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::WhaleEx::Market do
  it { expect(described_class::NAME).to eq 'whale_ex' }
  it { expect(described_class::API_URL).to eq 'https://api.whaleex.com/BUSINESS/api/public/v1' }
end
