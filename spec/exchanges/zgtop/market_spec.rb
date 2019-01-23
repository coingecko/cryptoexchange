require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zgtop::Market do
  it { expect(described_class::NAME).to eq 'zgtop' }
  it { expect(described_class::API_URL).to eq 'https://www.zg.top/API/api/v2' }
end
