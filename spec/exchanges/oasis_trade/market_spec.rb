require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OasisTrade::Market do
  it { expect(described_class::NAME).to eq 'oasis_trade' }
  it { expect(described_class::API_URL).to eq 'https://api.oasisdex.com/v2' }
end
