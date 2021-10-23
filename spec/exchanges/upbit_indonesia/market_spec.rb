require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::UpbitIndonesia::Market do
  it { expect(described_class::NAME).to eq 'upbit_indonesia' }
  it { expect(described_class::API_URL).to eq 'https://crix-api-id.upbit.com/v1/crix' }
end
