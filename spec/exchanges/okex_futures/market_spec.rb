require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OkexFutures::Market do
  it { expect(described_class::NAME).to eq 'okex_futures' }
  it { expect(described_class::API_URL).to eq 'https://www.okex.com/api/swap/v3' }
end
