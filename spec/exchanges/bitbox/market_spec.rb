require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitbox::Market do
  it { expect(described_class::NAME).to eq 'bitbox' }
  it { expect(described_class::API_URL).to eq 'https://openapi.bitfront.me/v1' }
end
