require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Secondbtc::Market do
  it { expect(described_class::NAME).to eq 'secondbtc' }
  it { expect(described_class::API_URL).to eq 'https://secondbtc.com/api/public' }
end
