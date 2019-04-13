require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinpark::Market do
  it { expect(described_class::NAME).to eq 'coinpark' }
  it { expect(described_class::API_URL).to eq 'https://api.coinpark.cc/v1' }
end
