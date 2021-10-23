require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Exnce::Market do
  it { expect(described_class::NAME).to eq 'exnce' }
  it { expect(described_class::API_URL).to eq 'https://exnce.com/api/v1' }
end
