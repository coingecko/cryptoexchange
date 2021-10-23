require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Bitsonic::Market do
  it { expect(described_class::NAME).to eq 'bitsonic' }
  it { expect(described_class::API_URL).to eq 'https://open-api.bitsonic.co.kr/api' }
end
