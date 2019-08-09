require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zoomex::Market do
  it { expect(described_class::NAME).to eq 'zoomex' }
  it { expect(described_class::API_URL).to eq 'https://www.zooomex.com/api/v2/trade' }
end
