require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitmex::Market do
  it { expect(described_class::NAME).to eq 'bitmex' }
  it { expect(described_class::API_URL).to eq 'https://www.bitmex.com/api/v1' }
end
