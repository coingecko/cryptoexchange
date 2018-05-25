require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hadax::Market do
  it { expect(described_class::NAME).to eq 'hadax' }
  it { expect(described_class::API_URL).to eq 'https://api.hadax.com' }
  it { expect(described_class::PAIRS_API_URL).to eq 'https://api.huobi.pro/v1/hadax/common/symbols' }
end
