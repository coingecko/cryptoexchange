require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Citex::Market do
  it { expect(described_class::NAME).to eq 'citex' }
  it { expect(described_class::API_URL).to eq 'https://api.citex.co.kr/v1/markets/common/ticker' }
end
