require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Luno::Market do
  it { expect(described_class::NAME).to eq 'luno' }
  it { expect(described_class::API_URL).to eq 'https://api.mybitx.com/api/1' }
end
