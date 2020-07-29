require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Coinlink::Market do
  it { expect(described_class::NAME).to eq 'coinlink' }
  it { expect(described_class::API_URL).to eq 'https://open-api.coinlink.co.kr/openApi' }
end
