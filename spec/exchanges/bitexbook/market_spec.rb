require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitexbook::Market do
  it { expect(described_class::NAME).to eq 'bitexbook' }
  it { expect(described_class::API_URL).to eq 'https://api.bitexbook.com/api/v2' }
end
