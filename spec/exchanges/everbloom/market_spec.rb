require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Everbloom::Market do
  it { expect(described_class::NAME).to eq 'everbloom' }
  it { expect(described_class::API_URL).to eq 'https://api.everbloom.co' }
end
