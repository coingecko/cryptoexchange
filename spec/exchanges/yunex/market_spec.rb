require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Yunex::Market do
  it { expect(described_class::NAME).to eq 'yunex' }
  it { expect(described_class::API_URL).to eq 'https://a.yunex.io' }
end
