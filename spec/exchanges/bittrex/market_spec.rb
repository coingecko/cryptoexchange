require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bittrex::Market do
  it { expect(described_class::NAME).to eq 'bittrex' }
  it { expect(described_class::API_URL).to eq 'https://bittrex.com/api/v1.1' }
end
