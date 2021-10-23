require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Vitex::Market do
  it { expect(described_class::NAME).to eq 'vitex' }
  it { expect(described_class::API_URL).to eq 'https://vitex.vite.net/api/v1' }
end
