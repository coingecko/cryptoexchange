require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Zebpay::Market do
  it { expect(described_class::NAME).to eq 'zebpay' }
  it { expect(described_class::API_URL).to eq 'https://www.zebapi.com/pro/v1' }
end
