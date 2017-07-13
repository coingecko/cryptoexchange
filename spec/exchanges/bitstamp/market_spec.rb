require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitstamp::Market do
  it { expect(described_class::NAME).to eq 'bitstamp' }
  it { expect(described_class::API_URL).to eq 'https://www.bitstamp.net/api/v2/ticker' }
end
