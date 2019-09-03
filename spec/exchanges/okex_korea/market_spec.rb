require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::OkexKorea::Market do
  it { expect(described_class::NAME).to eq 'okex_korea' }
  it { expect(described_class::API_URL).to eq 'https://okex.co.kr/api/spot/v3' }
end
