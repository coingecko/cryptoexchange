require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Citex::Market do
  it { expect(described_class::NAME).to eq 'citex' }
  it { expect(described_class::API_URL).to eq 'https://open.citex.co.kr/api/v1/common' }
end
