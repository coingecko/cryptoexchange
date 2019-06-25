require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Digifinex::Market do
  it { expect(described_class::NAME).to eq 'digifinex' }
  it { expect(described_class::API_URL).to eq 'https://openapi.digifinex.vip/v2' }
  it { expect(described_class::API_URL_V3).to eq 'https://openapi.digifinex.vip/v3' }
end
