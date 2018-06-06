require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitpaction::Market do
  it { expect(described_class::NAME).to eq 'bitpaction' }
  it { expect(described_class::API_URL).to eq 'https://api.bitpaction.com/api/v1' }
end
