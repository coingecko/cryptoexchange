require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::HuobiThailand::Market do
  it { expect(described_class::NAME).to eq 'huobi_thailand' }
  it { expect(described_class::API_URL).to eq 'https://www.huobi.co.th/api' }
end
