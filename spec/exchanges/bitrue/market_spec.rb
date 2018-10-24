require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitrue::Market do
  it { expect(described_class::NAME).to eq 'bitrue' }
  it { expect(described_class::API_URL).to eq 'https://www.bitrue.com' }
end
