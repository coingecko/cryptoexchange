require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dcoin::Market do
  it { expect(described_class::NAME).to eq 'dcoin' }
  it { expect(described_class::API_URL).to eq 'https://openapi.dcoin.com' }
end
