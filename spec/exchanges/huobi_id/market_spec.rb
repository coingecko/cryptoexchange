require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiId::Market do
  it { expect(described_class::NAME).to eq 'huobi_id' }
  it { expect(described_class::API_URL).to eq 'https://www.huobi.com.co/api' }
end
