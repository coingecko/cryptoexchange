require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bisq::Market do
  it { expect(described_class::NAME).to eq 'bisq' }
  it { expect(described_class::API_URL).to eq 'https://markets.bisq.network/api' }
end
