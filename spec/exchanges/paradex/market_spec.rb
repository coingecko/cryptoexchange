require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Paradex::Market do
  it { expect(described_class::NAME).to eq 'paradex' }
  it { expect(described_class::API_URL).to eq 'https://api.paradex.io/consumer' }
end
