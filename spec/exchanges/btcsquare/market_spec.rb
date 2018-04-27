require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcsquare::Market do
  it { expect(described_class::NAME).to eq 'btcsquare' }
  it { expect(described_class::API_URL).to eq 'https://www.btcsquare.net/api/v1' }
end
