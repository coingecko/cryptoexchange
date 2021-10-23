require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitcratic::Market do
  it { expect(described_class::NAME).to eq 'bitcratic' }
  it { expect(described_class::API_URL).to eq "https://www.bitcratic" }
end
