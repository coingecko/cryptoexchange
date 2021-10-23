require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BhexFutures::Market do
  it { expect(described_class::NAME).to eq 'bhex_futures' }
  it { expect(described_class::API_URL).to eq 'https://api.bhex.com/openapi/quote/v1' }
end
