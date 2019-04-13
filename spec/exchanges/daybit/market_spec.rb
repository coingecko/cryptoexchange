require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Daybit::Market do
  it { expect(described_class::NAME).to eq 'daybit' }
  it { expect(described_class::API_URL).to eq 'https://api.daybit.com/api/v1/public/market_summaries' }
end
