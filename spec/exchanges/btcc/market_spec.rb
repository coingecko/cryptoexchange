require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Btcc::Market do
  it { expect(described_class::NAME).to eq 'btcc' }
  it { expect(described_class::API_URL_USD).to eq 'https://spotusd-data.btcc.com/data/pro' }
  it { expect(described_class::API_URL_CNY).to eq 'https://pro-data.btcc.com/data/pro' }
end
