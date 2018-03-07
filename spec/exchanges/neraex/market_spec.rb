require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Neraex::Market do
  it { expect(described_class::NAME).to eq 'neraex' }
  it { expect(described_class::API_URL).to eq 'https://neraex.pro/api/v2' }
end
