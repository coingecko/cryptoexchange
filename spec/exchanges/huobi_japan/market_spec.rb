require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiJapan::Market do
  it { expect(described_class::NAME).to eq 'huobi_japan' }
  it { expect(described_class::API_URL).to eq 'https://api-cloud.huobi.co.jp' }
end
