require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinhe::Market do
  it { expect(described_class::NAME).to eq "coinhe" }
  it { expect(described_class::API_URL).to eq "https://api.coinhe.io/v1" }
end
