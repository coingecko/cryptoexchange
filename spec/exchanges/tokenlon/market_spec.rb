require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tokenlon::Market do
  it { expect(described_class::NAME).to eq 'tokenlon' }
  it { expect(described_class::API_URL).to eq 'https://tokenlon-core-market.tokenlon.im/rest' }
end
