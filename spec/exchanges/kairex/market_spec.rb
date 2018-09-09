require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Kairex::Market do
  it { expect(described_class::NAME).to eq 'kairex' }
  it { expect(described_class::API_URL).to eq 'https://api.kairex.com/v1' }
end
