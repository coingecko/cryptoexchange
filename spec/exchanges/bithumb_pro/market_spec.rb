require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::BithumbPro::Market do
  it { expect(described_class::NAME).to eq 'bithumb_pro' }
  it { expect(described_class::API_URL).to eq 'https://global-openapi.bithumb.pro/openapi/v1' }
end
