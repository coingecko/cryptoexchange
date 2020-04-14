require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::CryTrex::Market do
  it { expect(described_class::NAME).to eq 'cry_trex' }
  it { expect(described_class::API_URL).to eq 'https://crytrex.com/public_api' }
end
