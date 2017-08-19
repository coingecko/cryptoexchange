require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Tidex::Market do
  it { expect(described_class::NAME).to eq 'tidex' }
  it { expect(described_class::API_URL).to eq 'https://api.tidex.com/api/3' }
end
