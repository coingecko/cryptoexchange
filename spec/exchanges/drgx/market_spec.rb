require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Drgx::Market do
  it { expect(described_class::NAME).to eq 'drgx' }
  it { expect(described_class::API_URL).to eq 'https://exchange.drgx.io/cmc/public' }
end
