require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Upbit::Market do
  it { expect(described_class::NAME).to eq 'upbit' }
  it { expect(described_class::API_URL).to eq 'https://api.upbit.com/v1' }
end
