require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Okcoin::Market do
  it { expect(described_class::NAME).to eq 'okcoin' }
  it { expect(described_class::INT_API_URL).to eq 'https://www.okcoin.com/api/v1' }
  it { expect(described_class::CN_API_URL).to eq 'https://www.okcoin.cn/api/v1' }
end
