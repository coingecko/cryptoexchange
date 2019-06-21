require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiKorea::Market do
  it { expect(described_class::NAME).to eq 'huobi_korea' }
  it { expect(described_class::API_URL).to eq 'https://api-cloud.huobi.co.kr' }
end
