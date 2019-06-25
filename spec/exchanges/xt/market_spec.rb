require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Xt::Market do
  it { expect(described_class::NAME).to eq 'xt' }
  it { expect(described_class::API_URL).to eq 'https://kline.xt.com/api/data/v1' }
end
