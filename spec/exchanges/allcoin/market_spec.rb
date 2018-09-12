require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Allcoin::Market do
  it { expect(described_class::NAME).to eq 'allcoin' }
  it { expect(described_class::API_URL).to eq 'https://www.allcoin.ca' }
end
