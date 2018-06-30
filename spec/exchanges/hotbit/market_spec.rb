require 'spec_helper'

RSpec.describe Cryptoexchange::Exchanges::Hotbit::Market do
  it { expect(described_class::NAME).to eq 'hotbit' }
  it { expect(described_class::API_URL).to eq 'https://api.hotbit.io/api/v1' }
end
