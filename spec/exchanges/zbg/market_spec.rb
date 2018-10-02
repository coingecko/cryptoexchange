require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zbg::Market do
  it { expect(described_class::NAME).to eq 'zbg' }
  it { expect(described_class::API_URL).to eq 'https://kline.zbg.com/api/data/v1' }
end
