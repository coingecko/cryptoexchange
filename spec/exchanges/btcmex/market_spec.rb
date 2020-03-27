require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcmex::Market do
  it { expect(described_class::NAME).to eq 'btcmex' }
  it { expect(described_class::API_URL).to eq 'https://www.btcmex.com/api/v1' }
end
