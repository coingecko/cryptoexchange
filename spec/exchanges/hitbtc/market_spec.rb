require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hitbtc::Market do
  it { expect(described_class::NAME).to eq 'hitbtc' }
  it { expect(described_class::API_URL).to eq 'http://api.hitbtc.com/api/1' }
end
