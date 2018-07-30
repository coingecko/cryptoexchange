require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CPatex::Market do
  it { expect(described_class::NAME).to eq 'c_patex' }
  it { expect(described_class::API_URL).to eq 'https://c-patex.com:443/api/v2' }
end
