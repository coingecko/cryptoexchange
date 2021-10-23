require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Synthetix::Market do
  it { expect(described_class::NAME).to eq 'synthetix' }
  it { expect(described_class::API_URL).to eq 'https://exchange.api.synthetix.io/api' }
end
