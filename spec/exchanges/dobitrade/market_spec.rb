require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Dobitrade::Market do
  it { expect(described_class::NAME).to eq 'dobitrade' }
  it { expect(described_class::API_URL).to eq 'https://api.dobiex.io' }
end
