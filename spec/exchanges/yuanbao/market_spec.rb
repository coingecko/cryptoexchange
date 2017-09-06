require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Yuanbao::Market do
  it { expect(described_class::NAME).to eq 'yuanbao' }
  it { expect(described_class::API_URL).to eq 'https://www.yuanbao.com/api_market/getinfo_cny/coin' }
end
