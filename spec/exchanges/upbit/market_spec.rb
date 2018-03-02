require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Upbit::Market do
  it { expect(described_class::NAME).to eq 'upbit' }
  it { expect(described_class::API_URL).to eq 'https://crix-api-endpoint.upbit.com/v1/crix/candles' }
end
