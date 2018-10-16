require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Alluma::Market do
  it { expect(described_class::NAME).to eq 'alluma' }
  it { expect(described_class::API_URL).to eq 'https://trade.alluma.io' }
end
