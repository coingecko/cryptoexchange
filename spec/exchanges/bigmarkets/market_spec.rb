require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bigmarkets::Market do
  it { expect(described_class::NAME).to eq 'bigmarkets' }
  it { expect(described_class::API_URL).to eq 'http://api.bigmarkets.io' }
end
