require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zb::Market do
  it { expect(described_class::NAME).to eq 'zb' }
  it { expect(described_class::API_URL).to eq 'http://api.zb.cn/data/v1' }
end
