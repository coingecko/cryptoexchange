require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bybit::Market do
  it { expect(described_class::NAME).to eq 'bybit' }
  it { expect(described_class::API_URL).to eq 'https://api.bybit.com/v2/public' }
end
