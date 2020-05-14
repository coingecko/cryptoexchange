require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitstorage::Market do
  it { expect(described_class::NAME).to eq 'bitstorage' }
  it { expect(described_class::API_URL).to eq 'https://pub.bitstorage.finance/v2' }
end
