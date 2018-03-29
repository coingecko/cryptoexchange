require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bibox::Market do
  it { expect(described_class::NAME).to eq 'bibox' }
  it { expect(described_class::API_URL).to eq 'https://api.bibox.com/v1' }
end
