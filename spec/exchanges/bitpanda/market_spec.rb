require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitpanda::Market do
  it { expect(described_class::NAME).to eq 'bitpanda' }
  it { expect(described_class::API_URL).to eq 'https://api.exchange.bitpanda.com/public/v1' }
end
