require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitfinex::Market do
  it { expect(described_class::NAME).to eq 'bitfinex' }
  it { expect(described_class::API_URL).to eq 'https://api.bitfinex.com/v1' }
end
